#include <string.h>

#include "HeaderFiles/mode0.h"
#include "HeaderFiles/sprite.h"
#include "HeaderFiles/objectMovement.h"
#include "HeaderFiles/DMA.h"
#include "HeaderFiles/button.h"
#include "HeaderFiles/timer.h"
#include "HeaderFiles/soundHeader.h"

#include "Tiles/Senary.raw.h"
#include "Tiles/Senary.pal.h"
#include "Maps/Senary.map.h"

#include "Sprites/Chameleon.h"

//Sound files
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

//Declaring some globals
unsigned short* bg0map = (unsigned short*)ScreenBaseBlock(31); //Background (can't interact)
unsigned short* bg1map = (unsigned short*)ScreenBaseBlock(16); //Background (interactable)
int nextRight,nextLeft,nextRightDestination,nextLeftDestination,goingRight,scrolling_x,scrolling_y; //Scrolling controls
unsigned short prev_timer3;
Moveable moveableHead;

const unsigned char *sndLocation = NULL;
const long int *sndLength = NULL;
const unsigned char *musLocation = NULL;
const long int *musLength = NULL;

//define sound file data
sound channelSnd = {&sndLocation, 8000, &sndLength}; //channel 0
sound channelMus = {&musLocation, 8000, &musLength}; //channel 1

/*sound attackSnd = {&attack_bin, 8000, 1120};
sound caw1Snd = {&caw1_bin, 8000, 16144};
sound caw2Snd = {&caw2_bin, 8000, 18064};
sound deathSnd = {&death_bin, 8000, 11568};
sound enemy_die2Snd = {&enemy_die2_bin, 8000, 1424};
sound getflySnd = {&getfly_bin, 8000, 5136};
sound jumpSnd = {&jump_bin, 8000, 2672};
sound omnom1Snd = {&omnom1_bin, 8000, 10160};

sound level01Mus = {&level01_bin, 8000, 497936};
sound level02Mus = {&level02_bin, 8000, 450384};
sound level03Mus = {&level03_bin, 8000, 766160};
sound mainmenuMus = {&mainmenu_bin, 8000, 1225104};
sound victoryMus = {&victory_bin, 8000, 244944};*/

void init(void);
void update(void);
void playerMovement(void);
void leftScroll(void);
void rightScroll(void);
void draw(void);

//load sound functions
void load_Sound(const unsigned char*, const long int*, int); // int = 0 for sound, 1 for music

int main(void){
    init();
    
    while(1){
        update();
        
        draw();
    }
    
    return 0;
}

void init(void){
    int i;
    
    //Set up the non-interactive background.
    setMode(0);
    enableBG0();
    enableBG1();
    REG_BG0CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (31 << SCREEN_SHIFT);
    REG_BG1CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (16 << SCREEN_SHIFT);
    
    //This is just a temporary map from my original scrolling assignment.
    DMAFastCopy((void*)Senary_Palette, (void*)BGPaletteMem,256, DMA_16NOW);

    DMAFastCopy((void*)Senary_Tiles,(void*)CharBaseBlock(0),1440,DMA_32NOW);
    
    //Copy the first 30 columns in.
    for (i=0;i<30;i++){
        copyColumn(Senary_map,i,150,32,bg0map,i,32,32);
    }
    
    //Set up the scrolling information.
    nextLeft=149; //Where the map will be copied from when the screen scrolls left.
    nextRight=30; //Same, but for the right.
    nextLeftDestination=31; //Where the map will be copied into when the screen scrolls left.
    nextRightDestination=30; //^ Right
    copyColumn(Senary_map,nextLeft,150,32,bg0map,nextLeftDestination,32,32); //Copy the leftmost column in, because movement to the left won't trigger the column copy initially.
    //Reset the scrolling registers.
    REG_BG0HOFS=0;
    scrolling_x=0;
    REG_BG0VOFS=0;
    scrolling_y=0;
    
    goingRight=-1; //Not going left or right
    
	//allocate memory for sound length data
	sndLength = malloc(sizeof(const long int)* 1);
	musLength = malloc(sizeof(const long int)* 1);
	
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
    DMAFastCopy((void*)ChameleonPalette, (void*)spritePal,256, DMA_16NOW);

    copyToSpriteData(ChameleonData,Chameleon_WIDTH*Chameleon_HEIGHT,0);
    
    //Setup player object
    sprites[0].fields.x=50;
    sprites[0].fields.y=50;
    sprites[0].fields.tileIndex=0;
    //Setup player movement controller
    moveableHead.parentSprite=&sprites[0];
    moveableHead.hSpeed=4;
    moveableHead.vSpeed=1;
    moveableHead.next=NULL;
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
    
    //Timer 2 runs at ~38.4 FPS. This is the speed of button presses - they will only be interpreted when timer 2 is 0 (or -0x2000, whichever)
    //Timer 3 increments once every time timer 2 does. This is for things that need to run slower than button presses.
    //REG_TM2D = -0x80;
    REG_TM2D = -0x200;
    REG_TM2CNT = TIMER_FREQUENCY_64;
    REG_TM3CNT = TIMER_ENABLE | TIMER_OVERFLOW;
    REG_TM2CNT |= TIMER_ENABLE;
    prev_timer3=REG_TM3D;
    
    /*enable timer for sound*/
    REG_TM0D = 65536 - (16777216 / 8000);
    REG_TM0CNT = TIMER_ENABLE;
}

void update(void){
    pollButtons();
    
    if (REG_TM3D!=prev_timer3){
        if (REG_TM3D%4==0){
            prev_timer3=REG_TM3D;
            playerMovement();
        }
        prev_timer3=REG_TM3D;
    }
}

//Control player movement, including button presses
void playerMovement(void){
    if (checkState(BTN_RIGHT)){
        //Move right
        moveObject(&moveableHead,1,0,bg0map,scrolling_x,scrolling_y);
        
        //Scroll right if you aren't at the edge of the map
        while (scrolling_x<959                          //This is...uhh... 1200 - 240 - 1. Map width - screen width - 1
            && moveableHead.parentSprite->fields.x>160){   //How far along the screen we want to the player to be able to go
            rightScroll();
            moveableHead.parentSprite->fields.x--;
        }
    }
    else if (checkState(BTN_LEFT)){
        
        moveObject(&moveableHead,-1,0,bg0map,scrolling_x,scrolling_y);
        
        //Scroll left if you aren't at the left edge of the map
        while (scrolling_x>0
            && moveableHead.parentSprite->fields.x<40){
            leftScroll();
            moveableHead.parentSprite->fields.x++;
        }
    }
    
//    gravityControls();
    

    //If we want vertical maps, we need a copy row function.
    if ( checkState(BTN_UP) && 1 || hitDetection(&moveableHead,scrolling_x+0,scrolling_y+1,bg0map) ){
        moveObject(&moveableHead,0,-1,bg0map,scrolling_x,scrolling_y);
        //moveableHead.vSpeed-=10;
    }
    if (checkState(BTN_DOWN)){
        moveObject(&moveableHead,0,1,bg0map,scrolling_x,scrolling_y);
    }
    
    gravityControls(&moveableHead);
}

void rightScroll(void){
    scrolling_x++; //Scroll right. This will be applied to the scrolling register during the draw portion
    if (scrolling_x%8==1){ //If starting on a new column in the scrolling, copy the next column in to be prepared
        copyColumn(Senary_map,nextRight,150,32,bg0map,nextRightDestination,32,32);
        
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
    scrolling_x--;

    if (scrolling_x%8==7){
        copyColumn(Senary_map,nextLeft,150,32,bg0map,nextLeftDestination,32,32);
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

void draw(void){
    waitVBlank();
    //Update the scrolling registers. Do it here to avoid screen tearing.
    REG_BG0HOFS=scrolling_x;
    REG_BG0VOFS=scrolling_y;
    REG_BG1HOFS=scrolling_x;
    REG_BG1VOFS=scrolling_y;
    //Update OAM memory
    writeToOAM();
    
    int i;
    for (i=0;i<1024;i++){
        bg1map[i]=0;
    }
    
    //The error is in the scrolling registers NOT WORKING LIKE MY FUCKING MANUAL ONES

    bg1map[((sprites[0].fields.y+scrolling_y)%256)/8*32+((sprites[0].fields.x+scrolling_x)%256)/8]=10;
    /*
    spritePal[254]=scrolling_x;
    spritePal[255]=scrolling_y;
    spritePal[252]=REG_BG0HOFS;
    spritePal[253]=REG_BG0VOFS;
    */
}

/*sound loading functions*/
void load_Sound(const unsigned char *sample, const long int *length, int type){
	if(type == 0){
		sndLength = length;
		sndLocation = malloc(sizeof(const unsigned char)*&length);
		mempcy(sample, sndLocation, &length);
	} else {
		musLength = length;
		musLocation = malloc(sizeof(const unsigned char)*&length);
		mempcy(sample, sndLocation, &length);
	}
}
