#include "HeaderFiles/mode0.h"
#include "HeaderFiles/sprite.h"
#include "HeaderFiles/DMA.h"
#include "HeaderFiles/button.h"

#include "Tiles/Senary.raw.h"
#include "Tiles/Senary.pal.h"
#include "Maps/Senary.map.h"

//Declaring some globals
unsigned short* bg0map = (unsigned short*)ScreenBaseBlock(31); //Background (can't interact)
unsigned short* bg1map = (unsigned short*)ScreenBaseBlock(16); //Background (interactable)
int nextRight,nextLeft,nextRightDestination,nextLeftDestination,goingRight,scrolling_x,scrolling_y; //Scrolling controls

void init(void);
void update(void);
void playerMovement(void);
void leftScroll(void);
void rightScroll(void);
void draw(void);

int main(void){
    init();
    
    while(1){
        update();
        
        draw();
        
        { //This will need to be changed for timers
            int i=0;
            for (;i<5000;i++);
        }
    }
    
    return 0;
}

void init(void){
    int i;
    
    //Set up the non-interactive background.
    setMode(0);
    enableBG0();
    REG_BG0CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (31 << SCREEN_SHIFT);
    
    //This is just a temperary map from my original scrolling assignment.
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
    
    //Setup objects
    setObjMap1d();
    enableObjects();
    
    //Reset sprites
    for (i=0;i<128;i++){
        sprites[i].fields.x=240;
        sprites[i].fields.y=160;
    }
}

void update(void){
    pollButtons();
    playerMovement();
}

//Control player movement, including button presses
void playerMovement(void){
    if (checkState(BTN_RIGHT)){
        //Scroll right if you aren't at the edge of the map
        if (scrolling_x<959) //This is...uhh... 1200 - 240 - 1. Map width - screen width - 1
            rightScroll();
    }
    else if (checkState(BTN_LEFT)){
        //Scroll left if you aren't at the left edge of the map
        if (scrolling_x>0)
            leftScroll();
    }
    
    //If we want vertical maps, we need a copy row function.
    if (checkState(BTN_UP)){
        scrolling_y--;
    }
    if (checkState(BTN_DOWN)){
        scrolling_y++;
    }
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
}
