#include <string.h>

#ifndef REG_DISPCNT
    #define REG_DISPCNT *(unsigned long*) 0x4000000
#endif

#define spriteMem ((unsigned short*) 0x7000000)
//#define spriteData ((unsigned short*) 0x6010000)
#define spritePal ((unsigned short*) 0x5000200)

#define OBJ_TOGGLE 0x1000
#define enableObjects() (REG_DISPCNT |= OBJ_TOGGLE)
#define disableObjects() (REG_DISPCNT &= ~OBJ_TOGGLE)
#define toggleObjects() (REG_DISPCNT ^= OBJ_TOGGLE)
#define OBJ_MAP_2D 0x0
#define OBJ_MAP_1D 0x40
#define setObjMap1d() (REG_DISPCNT |= OBJ_MAP_1D)
#define setObjMap2d() (REG_DISPCNT &= ~OBJ_MAP_1D)
#define setObjMap(d) (REG_DISPCNT = (REG_DISPCNT & ~OBJ_MAP_1D) | (d))

//attribute0
#define ROTATION_FLAG 0x100
#define SIZE_DOUBLE 0x200
#define MODE_NORMAL 0x0
#define MODE_TRANSPARENT 0X400
#define MODE_WINDOWED 0x800
#define MOSAIC 0x1000
#define COLOR_16 0x0000
#define COLOR_256 0x2000
#define SQUARE 0x0
#define TALL 0x8000
#define WIDE 0x4000

//attribute1
#define ROTDATA(n) ((n)<<9)
#define HORIZONTAL_FLIP 0x1000
#define VERTICAL_FLIP 0x2000
#define SIZE_8 0x0
#define SIZE_16 0x4000
#define SIZE_32 0x8000
#define SIZE_64 0xC000

//attribute2
#define PRIORITY(n) ((n)<<10)
#define PALETTE(n) ((n)<<12)


typedef struct tagSprite1{
    unsigned short attribute[4];
} SpriteAttributes;

volatile unsigned short *spriteData=((unsigned short*) 0x6010000);

typedef struct tagSprite2{
    //Attribute 0
    unsigned int y:8;
    unsigned int isAffine:2;
    unsigned int gfxMode:2;
    unsigned int mosaic:1;
    unsigned int colorMode:1;
    unsigned int shape:2;

    //Attribute 1
    unsigned int x:9;
    unsigned int filler:3;
    unsigned int horizontalFlip:1;
    unsigned int verticalFlip:1;
    unsigned int size:2;

    //Attribute 2
    unsigned int tileIndex:10;
    unsigned int priority:2;
    unsigned int paletteBank:4;

    //Attribute 3
    unsigned int att3filler:16;
} SpriteFields;


typedef union tagSprite3{
    SpriteFields fields;
    SpriteAttributes attributes;
} Sprite, *pSprite;

//sprites[i].fields.x = #HERE;
Sprite sprites[128];

void copySpritePalette(unsigned short myPalette[256]){
    int i;
    for (i=0;i<256;i++){
        spritePal[i]=myPalette[i];
    }
}


void writeToOAM(void){
    int i,attr;
    for (i=0;i<128;i++){
        for (attr=0;attr<4;attr++){
            spriteMem[i*4+attr]=sprites[i].attributes.attribute[attr];
        }
    }
}

void copyToSpriteData(const unsigned short* image,size_t length, int location){
    int i;
    for (i=0;i<length>>1;i++){
        spriteData[i+location]=image[i];
    }
}

void* copyToSpritePalette(const unsigned short* palette){
    return memcpy(spritePal,palette,256);
}
