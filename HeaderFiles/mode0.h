#include <stdlib.h>

#define REG_BG0HOFS *(volatile unsigned short*) 0x4000010
#define REG_BG0VOFS *(volatile unsigned short*) 0x4000012
#define REG_BG1HOFS *(volatile unsigned short*) 0x4000014
#define REG_BG1VOFS *(volatile unsigned short*) 0x4000016
#define REG_BG2HOFS *(volatile unsigned short*) 0x4000018
#define REG_BG2VOFS *(volatile unsigned short*) 0x400001A
#define REG_BG3HOFS *(volatile unsigned short*) 0x400001C
#define REG_BG3VOFS *(volatile unsigned short*) 0x400001E

#define REG_BG0CNT *(volatile unsigned short*) 0x4000008
#define REG_BG1CNT *(volatile unsigned short*) 0x400000A
#define REG_BG2CNT *(volatile unsigned short*) 0x400000C
#define REG_BG3CNT *(volatile unsigned short*) 0x400000E
#define BG_COLOR256 0x80
#define CHAR_SHIFT 2
#define SCREEN_SHIFT 8
#define WRAPAROUND 0x1

#define BGPaletteMem ((unsigned short*)0x5000000)

#define TEXTBG_SIZE_256x256 0x0
#define TEXTBG_SIZE_256x512 0x8000
#define TEXTBG_SIZE_512x256 0x4000
#define TEXTBG_SIZE_512x512 0xC000

#define CharBaseBlock(n) (((n)*0x4000)+0x6000000)
#define ScreenBaseBlock(n) (((n)*0x800)+0x6000000)

#define setMode(mode) REG_DISPCNT = ( (unsigned long)(mode) )
#define REG_DISPCNT *(unsigned long*) 0x4000000
#define REG_DISPSTAT   *(volatile unsigned short*)0x4000004
#define MODE_0 0x0

#define BG0_TOGGLE 0x100
#define toggleBG0() REG_DISPCNT ^= BG0_TOGGLE
#define enableBG0() REG_DISPCNT |= BG0_TOGGLE
#define disableBG0() REG_DISPCNT &= ~BG0_TOGGLE

#define BG1_TOGGLE 0x200
#define toggleBG1() REG_DISPCNT ^= BG1_TOGGLE
#define enableBG1() REG_DISPCNT |= BG1_TOGGLE
#define disableBG1() REG_DISPCNT &= ~BG1_TOGGLE

#define BG2_TOGGLE 0x400
#define toggleBG2() REG_DISPCNT ^= BG2_TOGGLE
#define enableBG2() REG_DISPCNT |= BG2_TOGGLE
#define disableBG2() REG_DISPCNT &= ~BG2_TOGGLE

#define BG3_TOGGLE 0x800
#define toggleBG3() REG_DISPCNT ^= BG3_TOGGLE
#define enableBG3() REG_DISPCNT |= BG3_TOGGLE
#define disableBG3() REG_DISPCNT &= ~BG3_TOGGLE

typedef unsigned short u16;

u16 *videoBuffer = (u16*) 0x6000000;
u16 *paletteMem = (u16*)0x5000000;

volatile unsigned short *scanlineCounter = (volatile unsigned short*)0x4000006;


inline int xBoundsCheck(int x);
inline int yBoundsCheck(int y);

void waitVBlank(void){
    while (*scanlineCounter < 160){}
}

void addToPalette(const u16 palette[256],int start,int end){
    end=(end<=256)?end:256;
    for (;start<end;start++){
        paletteMem[start]=palette[start];
    }
}


//Copies a vertical column of tiles from a source map to the map on screen.
//unsigned short *source: Array of references to tiles in the tile map
//int sourceStart: "x" location in the source array to start at. Also the top most tile to be copied in.
//int sourceWidth: The total width of the source map, in tiles, not pixels
//int sourceHeight: The height of the source map, though this isn't currently used.
//unsigned short *destination: The location to be copied into. A char based block.
//int destStart: Tile position (x/8) of where to copy the tiles into on screen.
//int destWidth: The width of the destination map. Probably 32
//int destHeight: The height of the destination map. Probably 32
void copyColumn(unsigned short *source,int sourceStart,int sourceWidth,int sourceHeight,unsigned short *destination,int destStart,int destWidth,int destHeight){
    int y;

    for(y = 0; y < sourceHeight; y++){
        destination[y*destWidth+destStart]=source[y*sourceWidth+sourceStart];
    }
}
