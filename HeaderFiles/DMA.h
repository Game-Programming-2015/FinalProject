#define REG_DMA1SAD *(volatile unsigned long*)0x40000BC //DMA1 source
#define REG_DMA1DAD *(volatile unsigned long*)0x40000C0 //DMA1 dest
#define REG_DMA1CNT_H *(volatile unsigned short*)0x40000C6 //DMA1 ctrl reg

#define REG_DMA2SAD *(volatile unsigned long*)0x40000C8 //DMA2 srouce
#define REG_DMA2DAD *(volatile unsigned long*)0x40000CC //DMA2 dest
#define REG_DMA2CNT_H *(volatile unsigned short*)0x40000D2 //DMA2 ctrl reg

#define REG_DMA3SAD (*(volatile unsigned int*)0x40000D4)
#define REG_DMA3DAD (*(volatile unsigned int*)0x40000D8)
#define REG_DMA3CNT (*(volatile unsigned int*)0x40000DC)

#define DMA_DEST_FIXED 0x40
#define DMA_REPEAT 0x200
#define DMA_TIMING_SYNC_TO_DISPLAY 0x3000
#define DMA_32_NEW 0x400
#define DMA_ENABLE_NEW 0x8000

#define DMA_ENABLE 0x80000000
#define DMA_TIMING_IMMEDIATE 0x00000000
#define DMA_16 0x00000000
#define DMA_32 0x04000000
#define DMA_32NOW (DMA_ENABLE | DMA_TIMING_IMMEDIATE | DMA_32)
#define DMA_16NOW (DMA_ENABLE | DMA_TIMING_IMMEDIATE | DMA_16)

void DMAFastCopy(void *source,void *dest,unsigned int count,unsigned int mode){
    if (mode == DMA_16NOW || mode==DMA_32NOW){
        REG_DMA3SAD = (unsigned int)source;
        REG_DMA3DAD = (unsigned int)dest;
        REG_DMA3CNT = count | mode;
    }
}
