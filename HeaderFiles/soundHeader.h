/*DMA registers*/
#define REG_DISPCNT *(unsigned long*)0x4000000
#define REG_DMA1SAD *(volatile unsigned long*)0x40000BC
#define REG_DMA1DAD *(volatile unsigned long*)0x40000C0
#define REG_DMA1CNT_H *(volatile unsigned short*)0x40000C6
#define REG_DMA2SAD *(volatile unsigned long*)0x40000C8
#define REG_DMA2DAD *(volatile unsigned long*)0x40000CC
#define REG_DMA2CNT_H *(volatile unsigned short*)0x40000D2

#define DMA_ENABLE 0x80000000
#define DMA_TIMING_IMMEDIATE 0x00000000
#define DMA_16 0x00000000
#define DMA_32 0x04000000

#define DMA_DEST_FIXED 64
#define DMA_REPEAT 512
#define DMA_TIMING_SYNC_TO_DISPLAY 4096 | 8192

#define DMA_32_NEW 1024
#define DMA_ENABLE_NEW 32768

/*timer registers*/
#define REG_TM0CNT     *(volatile unsigned short*)0x4000102
#define REG_TM0D       *(volatile unsigned short*)0x4000100
#define TIMER_ENABLE 0x80

/*sound registers*/
#define REG_SGCNT0_H *(volatile unsigned short*)0x4000082
#define REG_SGCNT1 *(volatile unsigned short*)0x4000084
#define DSOUND_A_RIGHT_CHANNEL 256
#define DSOUND_A_LEFT_CHANNEL 512
#define DSOUND_A_FIFO_RESET 2048
#define SND_MASTER_ENABLE 0x80

#define SND_OUTPUT_RATIO_25 0x0000
#define SND_OUTPUT_RATIO_50 0x0001
#define SND_OUTPUT_RATIO_100 0x0002
#define DSA_OUTPUT_RATIO_50 0x0000
#define DSA_OUTPUT_RATIO_100 0x0004
#define DSA_OUTPUT_TO_RIGHT 0x0100
#define DSA_OUTPUT_TO_LEFT 0x0200
#define DSA_OUTPUT_TO_BOTH 0x0300
#define DSA_TIMER0 0x0000
#define DSA_TIMER1 0x0400
#define DSA_FIFO_RESET 0x0800
#define DSB_OUTPUT_RATIO_50 0x0000
#define DSB_OUTPUT_RATIO_100 0x0008
#define DSB_OUTPUT_TO_RIGHT 0x1000
#define DSB_OUTPUT_TO_LEFT 0x2000
#define DSB_OUTPUT_TO_BOTH 0x3000
#define DSB_TIMER0 0x0000
#define DSB_TIMER1 0x4000
#define DSB_FIFO_RESET 0x8000

#define REG_FIFO_A_L 0x040000A0
#define REG_FIFO_A_H 0x040000A2
#define REG_FIFO_B_L 0x040000A4
#define REG_FIFO_B_H 0x040000A6

/*interrupt registers*/
#define REG_IME *(unsigned short*)0x4000208
#define REG_IE *(unsigned short*)0x4000200
#define REG_IF *(unsigned short*)0x4000202
#define REG_INTERRUPT *(unsigned long*)0x3007FFC
#define REG_DISPSTAT *(unsigned short*)0x4000004
#define INT_VBLANK 0x0001

/*boolean thing that I always seem to forget to use*/
#define bool int
#define true 1
#define false 0

typedef struct soundData{
	void *pBuffer;
	unsigned short sampleRate;
	int length;
	/*int channelId;*/
}sound;

unsigned short SamplePosition0 = 0;
unsigned short SampleLength0 = 0;

/*
unsigned short SamplePosition1 = 0;
unsigned short SampleLength1 = 0;
unsigned short SamplePosition2 = 0;
unsigned short SampleLength2 = 0;*/
unsigned short SamplePosition3 = 0;
unsigned short SampleLength3 = 0;
	
/*fucntion for playing sound*/
void PlaySound(sound *theSound, int music){
	unsigned short sample;
	
	/*output to both channels and reset FIFO*/
	REG_SGCNT0_H = DSA_OUTPUT_TO_RIGHT | DSA_OUTPUT_TO_LEFT | DSA_FIFO_RESET;
	
	/*enable all sound*/
	REG_SGCNT1 = SND_MASTER_ENABLE;
	
	/*DMA1 source address*/
	REG_DMA1SAD = (unsigned long)theSound->pBuffer;
	
	/*DMA1 destination address*/
	REG_DMA1DAD = REG_FIFO_A_L;
	
	/*DMA2 source address
	REG_DMA2SAD = (unsigned long)theSound->pBuffer;*/
	
	/*DMA2 destination address
	REG_DMA2DAD = REG_FIFO_A_L;*/
	
	/*write 32 bits to dma1dest per vblank*/
	REG_DMA1CNT_H = DMA_DEST_FIXED | DMA_REPEAT | DMA_32_NEW | DMA_TIMING_SYNC_TO_DISPLAY | DMA_ENABLE_NEW;

    /*write 32 bits to dma2dest per vblank
	REG_DMA2CNT_H = DMA_DEST_FIXED | DMA_REPEAT | DMA_32_NEW | DMA_TIMING_SYNC_TO_DISPLAY | DMA_ENABLE_NEW;*/
	
	
	/*sample rate*/
	sample = 16777216 / theSound->sampleRate;
	REG_TM0D = 65536 - sample;
	
	/*sample length*/
	SampleLength0 = theSound->length / sample * 15.57;
	SamplePosition0 = 0;
	
	/*cases for other sounds/music*/
	/*unsigned short SamplePosition1 = 0;
	unsigned short SampleLength1 = 0;
	unsigned short SamplePosition2 = 0;
	unsigned short SampleLength2 = 0;
	unsigned short SamplePosition3 = 0;*/
	unsigned short SampleLength3 = 0;
	
	/*enable timer*/
	REG_TM0CNT = TIMER_ENABLE;
}

void MyHandler(void)
{
	unsigned short Int_Flag;
	
	/*disable interrupts*/
	REG_IME = 0x00;
	
	/*backup interrupt flags*/
	Int_Flag = REG_IF;
	
	/*check vblank*/
	if((REG_IF & INT_VBLANK) == INT_VBLANK){
		/*check if samples are playing*/
		if(SampleLength0){
			
			/*increment position*/
			SamplePosition0++;
			if(SamplePosition0 > SampleLength0 || SamplePosition0 == -1){
				/*stop & reset length*/
				REG_TM0CNT = 0;
				REG_DMA1CNT_H = 0;
				//REG_DMA2CNT_H = 0;
				SampleLength0 = 0;
			}
		}
		/*
		if(SampleLength1){
			SamplePosition1++;
			if(SamplePosition1 > SampleLength1){
				REG_TM0CNT = 0;
				REG_DMA1CNT_H = 0;
				SampleLength1 = 0;
			}
		}

		if(SampleLength2){
			SamplePosition2++;
			if(SamplePosition2 > SampleLength2){
				REG_TM0CNT = 0;
				REG_DMA1CNT_H = 0;
				SampleLength2 = 0;
			}
		}
		/*check music
		if(SampleLength3){
			
			/*increment position, else end unless music
			SamplePosition3++;
			if(SamplePosition3 > SampleLength3)
			{
				REG_TM0CNT = 0;
				REG_DMA1CNT_H = 0;
				SampleLength3 = 0;
			}
		}*/
	}
	
	/*restore interrupt flags*/
	REG_IF = Int_Flag;
	
	/*enable interrupts*/
	REG_IME = 0x01;
}

/*interrupt handler*/
int setInterruptHandler(void)
{
	REG_IME = 0x00;
	REG_INTERRUPT = (unsigned long)MyHandler;
	REG_IE |= INT_VBLANK;
	REG_DISPSTAT |= 0x08;
	REG_IME = 0x01;
}