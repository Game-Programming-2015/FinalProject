#define REG_DMA3SAD (*(volatile unsigned int*)0x40000D4)
#define REG_DMA3DAD (*(volatile unsigned int*)0x40000D8)
#define REG_DMA3CNT (*(volatile unsigned int*)0x40000DC)

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
