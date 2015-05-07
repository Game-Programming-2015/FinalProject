#include <string.h>

#include "Sprites/Sprites.h"
//#include "Sprites/Chameleon.h"
#include "Sprites/Flies.h"
#include "Sprites/FireDrop.h"

#include "HeaderFiles/button.h"
#include "HeaderFiles/mode0.h"
#include "HeaderFiles/sprite.h"
#include "HeaderFiles/objectMovement.h"
#include "HeaderFiles/DMA.h"
#include "HeaderFiles/timer.h"
#include "HeaderFiles/soundHeader.h"

/*
#include "Tiles/Senary.raw.h"
#include "Tiles/Senary.pal.h"
#include "Maps/Senary.map.h"
*/
#include "Maps/LevelOne/LevelOnePlatforms.map.h"
#include "Tiles/LevelOne/LevelOnePlatformTiles.raw.h"
#include "Tiles/LevelOne/LevelOnePalette.pal.h"
#include "Tiles/LevelOne/LevelOneTiles.raw.h"
#include "Maps/LevelOne/LevelOneMap.map.h"

//Sound files
//Tyler commented these out because it makes compiling take almost a minute when they're included, and I didn't want to sit through it. It compiles with them there just fine, though.
/*
#include "Sounds/attack.h"
#include "Sounds/caw1.h"
#include "Sounds/caw2.h"
#include "Sounds/death.h"
#include "Sounds/enemy_die2.h"
#include "Sounds/getfly.h"
#include "Sounds/jump.h"
#include "Sounds/level01.h"
#include "Sounds/level02.h"
#include "Sounds/level03.h"
#include "Sounds/mainmenu.h"
#include "Sounds/omnom1.h"
#include "Sounds/victory.h"
*/

//Function prototypes
void init(void);
void backgroundSetup(void);
void objectSetup(void);
void playerObjectSetup(void);
void tongueObjectSetup(void);
void flyObjectSetup(void);
void timerSetup(void);
void buttonTimerSetup(void);
void soundTimerSetup(void);
/*
void loadMainMenu(void);

void loadLevel01(void);
void loadLevel02(void);
void loadLevel03(void);
void loadVictory(void);*/

void update(void);
void updateAllObjectAnimation();
void nextFrameObject(Moveable*);
void nextFramePlayer(int);
void defaultFrame(void);
void nextFrameRun(void);
void nextFrameJump(void);
void nextFrameAttack(void);
void nextFrameJumpAttack(void);
void playerAnimationControls(void);
void playerMovement(void);
void scrollControls(void);
void leftScroll(void);
void rightScroll(void);
void downScroll(void);
void upScroll(void);
void tongueControls(void);

void draw(void);

//Declaring some globals
unsigned short* bg0map = (unsigned short*)ScreenBaseBlock(31); //Background (interactable)
unsigned short* bg1map = (unsigned short*)ScreenBaseBlock(16); //Debug background
unsigned short* bg2map = (unsigned short*)ScreenBaseBlock(15); //Background (can't interact)
int nextRight,nextLeft,nextRightDestination,nextLeftDestination,goingRight,scrolling_x,scrolling_y; //Scrolling controls
unsigned short *hitMap,*backMap;
unsigned short prev_timer3;
Moveable moveableHead;
HitBox tongueHitBox;

//define sound files
/*
sound attackSnd = {&attack_bin, 8000, 1120};
sound caw1Snd = {&caw1_bin, 8000, 16144};
sound caw2Snd = {&caw2_bin, 8000, 18064};
sound deathSnd = {&death_bin, 8000, 11568};
sound enemy_die2Snd = {&enemy_die2_bin, 8000, 1424};
sound getflySnd = {&getfly_bin, 8000, 5136};
sound jumpSnd = {&jump_bin, 8000, 2672};
sound omnom1Snd = {&omnom1_bin, 8000, 10160};
*/

int main(void){
    init();
    
    while(1){
        update();
        
        draw();
    }
    
    return 0;
}

void init(void){
    setMode(0);
	channelMus.sampleRate = 8000;
    backgroundSetup();
    objectSetup();
    timerSetup();
}

void timerSetup(void){
    buttonTimerSetup();
    soundTimerSetup();
}

void soundTimerSetup(void){
    //enable timer for sound
    REG_TM0D = 65536 - (16777216 / 8000);
    REG_TM0CNT = TIMER_ENABLE;
}

void buttonTimerSetup(void){
    //Timer 2 runs at ~38.4 FPS. This is the speed of button presses - they will only be interpreted when timer 2 is 0 (or -0x2000, whichever)
    //Timer 3 increments once every time timer 2 does. This is for things that need to run slower than button presses.
    REG_TM2D = -0x1600;
    REG_TM2CNT = TIMER_FREQUENCY_64;
    REG_TM3CNT = TIMER_ENABLE | TIMER_OVERFLOW;
    REG_TM2CNT |= TIMER_ENABLE;
    prev_timer3=REG_TM3D;
}

void objectSetup(void){
    int i;
    //Setup objects
    setObjMap1d();
    enableObjects();

    //Set sprite defaults
    for (i=0;i<128;i++){
        sprites[i].fields.x=240;
        sprites[i].fields.y=160;
        sprites[i].fields.colorMode=1;
        sprites[i].fields.size=2;
        sprites[i].fields.shape=1;
    }

    //Write sprite data in
    DMAFastCopy((void*)SpritesPalette, (void*)spritePal,256, DMA_16NOW);

    copyToSpriteData( SpritesData+256*Chameleon_run1 ,512,0);
    copyToSpriteData( SpritesData+256*Chameleon_tongueSprite ,512,256);
    //flies
    //red is at 16
    //orange is at 24
    //yellow is at 32
    //green 40
    //blue is at 48
    //indigo 56
    copyToSpriteData( FliesData ,3072,512);
    //copy in slime at 64
    copyToSpriteData(SpritesData+256*Slime_1, 1024, 2048);
    //copy in fire and drop
    //fire is at 80
    //drop is at 82
    copyToSpriteData(FireDropData, 8*24, 2560);
    //copyToSpriteData(SpritesData, Sprites_WIDTH*Sprites_HEIGHT, 0);
    
    //Sprites 0 and 1 are reserved for the player and the tongue
    playerObjectSetup();
    
    flyObjectSetup();
}

void playerObjectSetup(void){
    //Start player positions
    sprites[0].fields.x=84;
    sprites[0].fields.y=87;
    sprites[0].fields.tileIndex=0;
    //Setup player movement controller
    moveableHead.parentSprite=&sprites[0];
    moveableHead.hSpeed=0;
    moveableHead.vSpeed=0;
    moveableHead.next=NULL;
    moveableHead.collisionHandler=playerCollisionHandler;
    //Setup the main hitbox
    moveableHead.masterHitBox=malloc(sizeof(HitBox));
    moveableHead.masterHitBox->x=0;
    moveableHead.masterHitBox->y=0;
    moveableHead.masterHitBox->xSize=32;
    moveableHead.masterHitBox->ySize=16;
    moveableHead.masterHitBox->parentSprite=moveableHead.parentSprite;
    //Setup the secondary hitboxes
    moveableHead.hitBoxList=moveableHead.masterHitBox;
    moveableHead.hitBoxCount=1;
    
    tongueObjectSetup();
}

void tongueObjectSetup(void){
    sprites[1].fields.x=240;
    sprites[1].fields.y=160;
    sprites[1].fields.tileIndex=16;
    
    tongueHitBox.x=0;
    tongueHitBox.y=8;
    tongueHitBox.xSize=17;
    tongueHitBox.ySize=2;
    tongueHitBox.parentSprite=&(sprites[1]);
}

void flyObjectSetup(void){
    Moveable *flyOne=malloc(sizeof(Moveable)*1);
    pHitBox flyOneHitbox=malloc(sizeof(HitBox)*1);
    
    sprites[2].fields.x=71;
    sprites[2].fields.y=184;
    sprites[2].fields.shape=0;
    sprites[2].fields.size=1;
    sprites[2].fields.tileIndex=redFlyOne;
    
    flyOne->parentSprite=&(sprites[2]);
    flyOne->hSpeed=0;
    flyOne->vSpeed=0;
    flyOne->currentFrame=redFlyOne;
    flyOne->nextFrame=redFlyTwo;
    
    flyOneHitbox->x=0;
    flyOneHitbox->y=0;
    flyOneHitbox->xSize=16;
    flyOneHitbox->ySize=16;
    flyOneHitbox->parentSprite=&(sprites[2]);
    
    flyOne->masterHitBox=flyOneHitbox;
    flyOne->hitBoxList=flyOneHitbox;
    flyOne->hitBoxCount=1;
    
    addMoveable(&moveableHead,flyOne);
    
    flyOne=malloc(sizeof(Moveable)*1);
    flyOneHitbox=malloc(sizeof(HitBox)*1);

    sprites[3].fields.x=360;
    sprites[3].fields.y=32;
    sprites[3].fields.shape=0;
    sprites[3].fields.size=1;
    sprites[3].fields.tileIndex=violetFlyTwo;

    flyOne->parentSprite=&(sprites[3]);
    flyOne->hSpeed=0;
    flyOne->vSpeed=0;
    flyOne->currentFrame=violetFlyTwo;
    flyOne->nextFrame=violetFlyOne;

    flyOneHitbox->x=0;
    flyOneHitbox->y=0;
    flyOneHitbox->xSize=16;
    flyOneHitbox->ySize=16;
    flyOneHitbox->parentSprite=&(sprites[3]);

    flyOne->masterHitBox=flyOneHitbox;
    flyOne->hitBoxList=flyOneHitbox;
    flyOne->hitBoxCount=1;

    addMoveable(&moveableHead,flyOne);
    
    flyOne=malloc(sizeof(Moveable)*1);
    flyOneHitbox=malloc(sizeof(HitBox)*1);

    sprites[4].fields.x=410;
    sprites[4].fields.y=34;
    sprites[4].fields.shape=0;
    sprites[4].fields.size=1;
    sprites[4].fields.tileIndex=blueFlyOne;

    flyOne->parentSprite=&(sprites[4]);
    flyOne->hSpeed=0;
    flyOne->vSpeed=0;
    flyOne->currentFrame=blueFlyOne;
    flyOne->nextFrame=blueFlyTwo;

    flyOneHitbox->x=0;
    flyOneHitbox->y=0;
    flyOneHitbox->xSize=16;
    flyOneHitbox->ySize=16;
    flyOneHitbox->parentSprite=&(sprites[4]);

    flyOne->masterHitBox=flyOneHitbox;
    flyOne->hitBoxList=flyOneHitbox;
    flyOne->hitBoxCount=1;

    addMoveable(&moveableHead,flyOne);
    
    //fire sprite
    flyOne=malloc(sizeof(Moveable)*1);
    flyOneHitbox=malloc(sizeof(HitBox)*1);

    sprites[5].fields.x=404;
    sprites[5].fields.y=72;
    sprites[5].fields.shape=0;
    sprites[5].fields.size=0;
    sprites[5].fields.tileIndex=fireOne;

    flyOne->parentSprite=&(sprites[5]);
    flyOne->hSpeed=0;
    flyOne->vSpeed=0;
    flyOne->currentFrame=fireOne;
    flyOne->nextFrame=fireTwo;

    flyOneHitbox->x=0;
    flyOneHitbox->y=0;
    flyOneHitbox->xSize=8;
    flyOneHitbox->ySize=8;
    flyOneHitbox->parentSprite=&(sprites[5]);

    flyOne->masterHitBox=flyOneHitbox;
    flyOne->hitBoxList=flyOneHitbox;
    flyOne->hitBoxCount=1;

    addMoveable(&moveableHead,flyOne);
    
    //acid sprite
    flyOne=malloc(sizeof(Moveable)*1);
    flyOneHitbox=malloc(sizeof(HitBox)*1);

    sprites[6].fields.x=285;
    sprites[6].fields.y=102;
    sprites[6].fields.shape=0;
    sprites[6].fields.size=0;
    sprites[6].fields.tileIndex=dropOne;

    flyOne->parentSprite=&(sprites[6]);
    flyOne->hSpeed=0;
    flyOne->vSpeed=0;
    flyOne->currentFrame=dropOne;
    flyOne->nextFrame=dropOne;

    flyOneHitbox->x=0;
    flyOneHitbox->y=0;
    flyOneHitbox->xSize=8;
    flyOneHitbox->ySize=8;
    flyOneHitbox->parentSprite=&(sprites[6]);

    flyOne->masterHitBox=flyOneHitbox;
    flyOne->hitBoxList=flyOneHitbox;
    flyOne->hitBoxCount=1;

    addMoveable(&moveableHead,flyOne);
}

//void fireObjectSetup(void){
//    Moveable *fireOne;//=malloc(sizeof(Moveable)*1);
//    pHitBox fireOneHitbox;//=malloc(sizeof(HitBox)*1);
//
//    sprites[5].fields.x=420;
//    sprites[5].fields.y=190;
//    sprites[5].fields.shape=0;
//    sprites[5].fields.size=1;
//    sprites[5].fields.tileIndex=fireOne;
//
//    fireOne->parentSprite=&(sprites[5]);
//    fireOne->hSpeed=0;
//    fireOne->vSpeed=0;
//    fireOne->currentFrame=fireOne;
//    fireOne->nextFrame=fireTwo;
//
//    fireOneHitbox->x=0;
//    fireOneHitbox->y=0;
//    fireOneHitbox->xSize=8;
//    fireOneHitbox->ySize=8;
//    fireOneHitbox->parentSprite=&(sprites[5]);
//
//    fireOne->masterHitBox=fireOneHitbox;
//    fireOne->hitBoxList=fireOneHitbox;
//    fireOne->hitBoxCount=1;
//
//    addMoveable(&moveableHead,fireOne);
//}

void backgroundSetup(void){
    int i;
    
    hitMap=malloc(sizeof(unsigned short)*2048);
    backMap=malloc(sizeof(unsigned short)*2048);
    enableBG0(); //Right now, this is the hitmap.
    enableBG1(); //This is a debug thing
    enableBG2(); //BG2 is the background
    REG_BG0CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (31 << SCREEN_SHIFT);
    REG_BG1CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (16 << SCREEN_SHIFT) | 2;
    REG_BG2CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (15 << SCREEN_SHIFT) | (3 << CHAR_SHIFT);

    //Load the pallete, tiles, and hitmap
    loadLevelOnePalette();

    loadLevelOneHitMapTiles((void*)CharBaseBlock(0));
    loadLevelOneBackgroundTiles((void*)CharBaseBlock(3));
    
    loadLevelOneHitMap(hitMap);
    loadLevelOneMap(backMap);

    //Copy the first 30 columns in.
    for (i=0;i<30;i++){
        copyColumn(hitMap,i,64,32,bg0map,i,32,32);
        copyColumn(backMap,i,64,32,bg2map,i,32,32);
    }

    //Set up the scrolling information.
    nextLeft=149; //Where the map will be copied from when the screen scrolls left.
    nextRight=30; //Same, but for the right.
    nextLeftDestination=31; //Where the map will be copied into when the screen scrolls left.
    nextRightDestination=30; //^ Right
    copyColumn(hitMap,nextLeft,64,32,bg0map,nextLeftDestination,32,32); //Copy the leftmost column in, because movement to the left won't trigger the column copy initially.
    copyColumn(backMap,nextLeft,64,32,bg2map,nextLeftDestination,32,32);
    //Reset the scrolling registers.
    REG_BG0HOFS=0;
    scrolling_x=0;
    REG_BG0VOFS=0;
    scrolling_y=0;

    goingRight=-1; //Not going left or right
}

void update(void){
    if (REG_TM3D!=prev_timer3){ //On button timer update
        pollButtons();
        //objectsAnimationUpdate();
        prev_timer3=REG_TM3D;
        playerMovement();
        scrollControls();

        //Don't do this every frame
        if (REG_TM3D%2)
            //Calculate the vSpeed for the player based on gravity
            gravityControls(&moveableHead,scrolling_x,scrolling_y,bg0map);
            
        //Move the player objects
        moveObject(&moveableHead,1,1,bg0map,scrolling_x,scrolling_y);
        
        playerAnimationControls();
        tongueControls();
        updateAllObjectAnimation();
    }
}

void updateAllObjectAnimation(void){
    Moveable *current=moveableHead.next;
    while (current!=NULL){
        nextFrameObject(current);
        current=current->next;
    }
}

void nextFrameObject(Moveable *object){
    object->parentSprite->fields.tileIndex=object->nextFrame;
    object->nextFrame=object->currentFrame;
    object->currentFrame=object->parentSprite->fields.tileIndex;
}

//update animations for player
void nextFramePlayer(int condition){
    //conditions are as follows:
    //0: moving
    //1: jump
    //3: attacking
    //4: jumping and attacking
    //use no condition if you want to return to default

    switch(condition){
        case 0:
        nextFrameRun();
        break;
        case 1:
        nextFrameJump();
        break;
        case 3:
        nextFrameAttack();
        break;
        case 4:
        nextFrameJumpAttack();
        break;
        default:
        defaultFrame();
        break;
    }

}

//note, these assume the chameleon sprite is at the first index(0)
void defaultFrame(void){
    //puts the main chameleon sprite back
    copyToSpriteData(SpritesData+(256*Chameleon_run1),Sprites_WIDTH*16,0);
}

void nextFrameRun(void){
    //places the run sprite at the chameleon sprite index
    copyToSpriteData(SpritesData+(256*Chameleon_run2),Sprites_WIDTH*16,0);
}

void nextFrameJump(void){
    //places jump sprite at chameleon sprite index
    copyToSpriteData(SpritesData+(256*Chameleon_jump),Sprites_WIDTH*16,0);
}

void nextFrameAttack(void){
    //places attack sprite at chameleon sprite index
    copyToSpriteData(SpritesData+(256*Chameleon_groundLick),Sprites_WIDTH*16,0);
}

void nextFrameJumpAttack(void){
    //places jump attack sprite at chameleon sprite index
    copyToSpriteData(SpritesData+(256*Chameleon_jumpLick),Sprites_WIDTH*16,0);
}

void playerAnimationControls(){
    //will decide what animation to play for the player based on conditions
    
    if(checkState(BTN_LEFT) || checkState(BTN_RIGHT)){
        if(REG_TM3D%2){
            nextFramePlayer(0);
        }
        else{
            nextFramePlayer(9);
        }
    }
    
    if(!hitDetection(&moveableHead,scrolling_x,scrolling_y+1,bg0map)){
        if(checkState(BTN_A)){
            nextFramePlayer(4);
        }
        else{
            nextFramePlayer(1);
        }
    }
    else{
        if(checkState(BTN_A)){
            nextFramePlayer(3);
        }
        else{
            nextFramePlayer(9);
        }
    }
    
}

//Update player movment, left/right/up with button presses, up/down with gravity
void playerMovement(void){
    if (checkState(BTN_RIGHT)){
        //Point the player in the right direction
        moveableHead.parentSprite->fields.horizontalFlip=0;
        //Tell the player object to move
        moveableHead.hSpeed=4;
        //The actual movement is taken care of later on.
    }
    else if (checkState(BTN_LEFT)){
        moveableHead.parentSprite->fields.horizontalFlip=1;
        moveableHead.hSpeed=-4;
    }
    else{
        moveableHead.hSpeed=0;
    }
    
    if ( checkPressed(BTN_UP)
      && hitDetection(&moveableHead,scrolling_x+0,scrolling_y+1,bg0map) //If there is a block directly below the player.
    ){
        moveableHead.vSpeed=-7; //Tell the player object to move up
        
    }
    //Debug thing
    if ( checkPressed(BTN_START) ){
        moveableHead.vSpeed=-10;
    }
}

void scrollControls(void){
    //Scroll right if you aren't at the edge of the map
    while (scrolling_x<271 //This is...uhh... 1200 - 240 - 1. Map width - screen width - 1
        && moveableHead.parentSprite->fields.x>160){ //How far along the screen we want to the player to be able to go

        rightScroll();
    }
    //Scroll left if you aren't at the left edge of the map
    while (scrolling_x>0
        && moveableHead.parentSprite->fields.x<40){

        leftScroll();
    }
    
    while (scrolling_y<96 //256-160
        && moveableHead.parentSprite->fields.y>120){
        
        downScroll();
    }
    
    while (scrolling_y>0
        && moveableHead.parentSprite->fields.y<40){

        upScroll();
    }
}


void downScroll(void){
    Moveable *currentMove;
    
    scrolling_y++;
    moveableHead.parentSprite->fields.y--;
    
    currentMove=moveableHead.next;
    while (currentMove!=NULL){
        currentMove->parentSprite->fields.y--;
        currentMove=currentMove->next;
    }
    
}

void upScroll(void){
    Moveable *currentMove;
    
    scrolling_y--;
    moveableHead.parentSprite->fields.y++;
    
    currentMove=moveableHead.next;
    while (currentMove!=NULL){
        currentMove->parentSprite->fields.y++;
        currentMove=currentMove->next;
    }
}

void rightScroll(void){
    Moveable *currentMove=moveableHead.next;
    
    scrolling_x++; //Scroll right. This will be applied to the scrolling register during the draw portion
    moveableHead.parentSprite->fields.x--;
    
    //Move all the object so they can move on/off screen.
    while (currentMove!=NULL){
        currentMove->parentSprite->fields.x--;
        currentMove=currentMove->next;
    }
    
    
    if (scrolling_x%8==1){ //If starting on a new column in the scrolling, copy the next column in to be prepared
        copyColumn(hitMap,nextRight,64,32,bg0map,nextRightDestination,32,32);
        copyColumn(backMap,nextRight,64,32,bg2map,nextRightDestination,32,32);
        
        //Increment the destinations.
        nextRight++;
        nextRightDestination++;
        nextLeft++;
        nextLeftDestination++;

        //Bounds checking. This is kind of avoided by the "Can't scroll past the edge" thing.
        if (nextRight>149)
            nextRight=0;
        if (nextRightDestination>31)
            nextRightDestination=0;

        if (nextLeft>149)
            nextLeft=0;
        if (nextLeftDestination>31)
            nextLeftDestination=0;
            
        //If you change directions, you have to double increment. It's a thing that I've always had to do and never understood why, in lots of things.
        if (!goingRight){
            nextRight++;
            nextRightDestination++;
            nextLeft++;
            nextLeftDestination++;
        }
        
        //Change directions. This would also be where you would update the hFlip.
        goingRight=1;
    }
}

//Essentially the same as rightScroll();
void leftScroll(void){
    Moveable *currentMove=moveableHead.next;
    
    scrolling_x--;
    moveableHead.parentSprite->fields.x++;
    
    while (currentMove!=NULL){
        currentMove->parentSprite->fields.x++;
        currentMove=currentMove->next;
    }

    if (scrolling_x%8==7){
        copyColumn(hitMap,nextLeft,64,32,bg0map,nextLeftDestination,32,32);
        copyColumn(backMap,nextLeft,64,32,bg2map,nextLeftDestination,32,32);
        nextRight--;
        nextRightDestination--;
        nextLeft--;
        nextLeftDestination--;

        if (goingRight){
            nextRight--;
            nextRightDestination--;
            nextLeft--;
            nextLeftDestination--;
        }

        if (nextRight<0)
            nextRight=149;
        if (nextRightDestination<0)
            nextRightDestination=31;

        if (nextLeft<0)
            nextLeft=149;
        if (nextLeftDestination<0)
            nextLeftDestination=31;


        goingRight=0;
    }
}

int isFly(pSprite sprite){
    return (sprite->fields.tileIndex>=32 && sprite->fields.tileIndex<=120);
}

void changeColor(pSprite flySprite){
    switch (flySprite->fields.tileIndex){
        case redFlyOne:
        case redFlyTwo:
            mainColor=redMain;
            secondaryColor=redSecondary;
            break;
        case orangeFlyOne:
        case orangeFlyTwo:
            mainColor=orangeMain;
            secondaryColor=orangeSecondary;
            break;
        case yellowFlyOne:
        case yellowFlyTwo:
            mainColor=yellowMain;
            secondaryColor=yellowSecondary;
            break;
        case greenFlyOne:
        case greenFlyTwo:
            mainColor=greenMain;
            secondaryColor=greenSecondary;
            break;
        case blueFlyOne:
        case blueFlyTwo:
            mainColor=blueMain;
            secondaryColor=blueSecondary;
            break;
        case violetFlyOne:
        case violetFlyTwo:
            mainColor=violetMain;
            secondaryColor=violetSecondary;
            break;
    }
}

void tongueControls(void){
    Moveable *currentMoveable = moveableHead.next;
    if ( checkState(BTN_A) ){
        sprites[1].fields.x=sprites[0].fields.x+32-64*sprites[0].fields.horizontalFlip;
        sprites[1].fields.y=sprites[0].fields.y;
        sprites[1].fields.horizontalFlip=sprites[0].fields.horizontalFlip;
    }
    else if ( checkReleased(BTN_A) ){
        sprites[1].fields.x=240;
        sprites[1].fields.y=240;
    }

    //Check if the tongue is hitting any flies
    while (currentMoveable!=NULL){
        if ( isFly(currentMoveable->parentSprite) && checkTwoHitBoxCollision(currentMoveable->masterHitBox,&tongueHitBox) ){
            //Maybe check for another collision from the subhitboxess
            changeColor(currentMoveable->parentSprite);
        }
        currentMoveable=currentMoveable->next;
    }
    /*
    //Debug thing
    if ( checkPressed(BTN_R) ){
        switch (mainColor){
            case redMain:
                mainColor=orangeMain;
                secondaryColor=orangeSecondary;
                break;
            case orangeMain:
                mainColor=yellowMain;
                secondaryColor=yellowSecondary;
                break;
            case yellowMain:
                mainColor=greenMain;
                secondaryColor=greenSecondary;
                break;
            case greenMain:
                mainColor=blueMain;
                secondaryColor=blueSecondary;
                break;
            case blueMain:
                mainColor=violetMain;
                secondaryColor=violetSecondary;
                break;
            case violetMain:
                mainColor=redMain;
                secondaryColor=redSecondary;
                break;
        }
    }
    else if ( checkPressed(BTN_L) ) {
        switch (mainColor){
            case yellowMain:
                mainColor=orangeMain;
                secondaryColor=orangeSecondary;
                break;
            case greenMain:
                mainColor=yellowMain;
                secondaryColor=yellowSecondary;
                break;
            case blueMain:
                mainColor=greenMain;
                secondaryColor=greenSecondary;
                break;
            case violetMain:
                mainColor=blueMain;
                secondaryColor=blueSecondary;
                break;
            case redMain:
                mainColor=violetMain;
                secondaryColor=violetSecondary;
                break;
            case orangeMain:
                mainColor=redMain;
                secondaryColor=redSecondary;
                break;
        }
    }*/
}

void draw(void){
    waitVBlank();
    //Update the scrolling registers. Do it here to avoid screen tearing.
    REG_BG0HOFS=scrolling_x;
    REG_BG0VOFS=scrolling_y;
    REG_BG1HOFS=scrolling_x;
    REG_BG1VOFS=scrolling_y;
    REG_BG2HOFS=scrolling_x;
    REG_BG2VOFS=scrolling_y;
    //Update OAM memory
    writeToOAM();

    int i;
    for (i=0;i<1024;i++){
        bg1map[i]=0;
    }
    for (i=0;i<=moveableHead.masterHitBox->ySize/8;i++){
        int j;
        for (j=0;j<=moveableHead.masterHitBox->xSize/8;j++){
            bg1map[((sprites[0].fields.y+scrolling_y+i*8)%256)/8*32+((sprites[0].fields.x+scrolling_x+j*8)%256)/8]=2;
        }
    }

}
/*
void loadMainMenu(void){
    songLength = set_mainmenu(&song);
    channelMus.pBuffer = song;
    channelMus.length = songLength;
}

void loadLevel01(void){
    songLength = set_level01(&song);
    channelMus.pBuffer = song;
    channelMus.length = songLength;
}

void loadLevel02(void){
    songLength = set_level02(&song);
    channelMus.pBuffer = song;
    channelMus.length = songLength;
}
void loadLevel03(void){
    songLength = set_level03(&song);
    channelMus.pBuffer = song;
    channelMus.length = songLength;
}

void loadVictory(void){
    songLength = set_victory(&song);
    channelMus.pBuffer = song;
    channelMus.length = songLength;
}*/
