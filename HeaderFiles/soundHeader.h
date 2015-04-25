#ifndef REG_DMA1SAD
#include "HeaderFiles/DMA.h"
#endif

/*DMA registers*/
#ifndef REG_DISPCNT
#define REG_DISPCNT *(unsigned long*)0x4000000
#endif

/*DMA flags*/

/*timer registers*/
#define REG_TM0CNT     *(volatile unsigned short*)0x4000102
#define REG_TM0D       *(volatile unsigned short*)0x4000100

#define TIMER_FREQUENCY_SYSTEM 0x0
#define TIMER_FREQUENCY_64 0x1
#define TIMER_FREQUENCY_256 0x2
#define TIMER_FREQUENCY_1024 0x3
#ifndef TIMER_OVERFLOW
#define TIMER_OVERFLOW 0x4
#endif
#define TIMER_ENABLE 0x80

/*sound registers*/
#define REG_SOUNDCNT_L *(volatile unsigned short*)0x4000080 //sound 1-4 output level & stereo ctrl
#define REG_SGCNT0_H *(volatile unsigned short*)0x4000082 //direct sound ctrl & sound 1-4 output ratio
#define REG_SGCNT1 *(volatile unsigned short*)0x4000084 //master sound enable & sound 1-4 play status

#define SND_MASTER_ENABLE 0x80 //enabler bits

#define SND_OUTPUT_RATIO_25 0x0000
#define SND_OUTPUT_RATIO_50 0x0001
#define SND_OUTPUT_RATIO_100 0x0002

/*DirectSound A flags*/
#define DSA_OUTPUT_RATIO_50 0x0000
#define DSA_OUTPUT_RATIO_100 0x0004
#define DSA_OUTPUT_TO_RIGHT 0x0100 //DirectSound A output left
#define DSA_OUTPUT_TO_LEFT 0x0200 //DirectSound A output right
#define DSA_OUTPUT_TO_BOTH 0x0300 //DirectSound A output both
#define DSA_TIMER0 0x0000
#define DSA_TIMER1 0x0400
#define DSA_FIFO_RESET 0x0800 //DirectSound A FIFO reset

/*DirectSound B flags*/
#define DSB_OUTPUT_RATIO_50 0x0000
#define DSB_OUTPUT_RATIO_100 0x0008
#define DSB_OUTPUT_TO_RIGHT 0x1000 //DirectSound B output left
#define DSB_OUTPUT_TO_LEFT 0x2000 //DirectSound B output right
#define DSB_OUTPUT_TO_BOTH 0x3000 //DirectSound B output both
#define DSB_TIMER0 0x0000
#define DSB_TIMER1 0x4000
#define DSB_FIFO_RESET 0x8000 //DirectSound B FIFO reset

/*DirectSound FIFO destination flags*/
#define REG_FIFO_A_L 0x040000A0 //DirectSound FIFO A sample 0-1
#define REG_FIFO_A_H 0x040000A2 //DirectSound FIFO A sample 2-3
#define REG_FIFO_B_L 0x040000A4 //DirectSound FIFO B sample 0-1
#define REG_FIFO_B_H 0x040000A6 //DirectSound FIFO B sample 2-3

/*interrupt registers*/
#define REG_IME *(unsigned short*)0x4000208
#define REG_IE *(unsigned short*)0x4000200
#define REG_IF *(unsigned short*)0x4000202
#define REG_INTERRUPT *(unsigned long*)0x3007FFC
#ifndef REG_DISPSTAT
#define REG_DISPSTAT *(unsigned short*)0x4000004
#endif
#define INT_VBLANK 0x0001

typedef struct soundData{
	void *pBuffer;
	unsigned short sampleRate;
	int length;
	/*int channelId;*/
}sound;

unsigned short sample = 16777216 / 8000;
unsigned short SamplePosition0 = 0;
unsigned short SampleLength0 = 0;
unsigned short SamplePosition1 = 0;
unsigned short SampleLength1 = 0;
void *playing = NULL; //*pointer to currently looping sound
	
/*fucntion for playing sound*/
void PlaySound(sound *theSound, int music){
	/*output to both channels and reset FIFOs*/
	REG_SGCNT0_H = DSA_OUTPUT_TO_RIGHT | DSA_OUTPUT_TO_LEFT | DSA_FIFO_RESET | DSB_OUTPUT_TO_RIGHT | DSB_OUTPUT_TO_LEFT | DSB_FIFO_RESET;
	
	/*enable all sound*/
	REG_SGCNT1 = SND_MASTER_ENABLE;
	
	if(music == 0){
    	/*DMA1 source address*/
    	REG_DMA1SAD = (unsigned long)theSound->pBuffer;
    	
    	/*DMA1 destination address*/
    	REG_DMA1DAD = REG_FIFO_A_L;
    	
    	/*write 32 bits to dma1dest per vblank*/
    	REG_DMA1CNT_H = DMA_DEST_FIXED | DMA_REPEAT | DMA_32_NEW | DMA_TIMING_SYNC_TO_DISPLAY | DMA_ENABLE_NEW;
    	
    	/*sample length*/
    	SampleLength0 = theSound->length / sample * 15.57;
    	SamplePosition0 = 0;
	} else {
    	/*DMA2 source address*/
    	REG_DMA2SAD = (unsigned long)theSound->pBuffer;
    	playing = (unsigned long)theSound->pBuffer;
    	
    	/*DMA2 destination address*/
    	REG_DMA2DAD = REG_FIFO_B_L;

        /*write 32 bits to dma2dest per vblank*/
    	REG_DMA2CNT_H = DMA_DEST_FIXED | DMA_REPEAT | DMA_32_NEW | DMA_TIMING_SYNC_TO_DISPLAY | DMA_ENABLE_NEW;
    	
        /*case for music*/
    	SampleLength1 = theSound->length / sample * 15.57;
    	SamplePosition1 = 0;
	}
}

/*sound handler*/
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
			if(SamplePosition0 > SampleLength0){
				/*stop & reset length*/
				REG_DMA1CNT_H = 0;
				SampleLength0 = 0;
			}
		}
		
		/*check music*/
		if(SampleLength1){
			SamplePosition1++;
			if(SamplePosition1 > SampleLength1){
				/*loop music*/
				SamplePosition1 = 0;
				REG_DMA2SAD = playing;
            	
            	/*DMA2 destination address*/
            	REG_DMA2DAD = REG_FIFO_B_L;

                /*write 32 bits to dma2dest per vblank*/
            	REG_DMA2CNT_H = DMA_DEST_FIXED | DMA_REPEAT | DMA_32_NEW | DMA_TIMING_SYNC_TO_DISPLAY | DMA_ENABLE_NEW;
			}
		}
	}
	
	/*restore interrupt flags*/
	REG_IF = Int_Flag;
	
	/*enable interrupts*/
	REG_IME = 0x01;
}

/*stop sound function*/
void StopSound(int channel){
	unsigned short Int_Flag;
	
	/*disable interrupts*/
	REG_IME = 0x00;
	
	/*backup interrupt flags*/
	Int_Flag = REG_IF;
	
	/*end sound*/
	if(channel == 0){	
		REG_DMA1CNT_H = 0;
		SampleLength0 = 0;
	} else {
		REG_DMA2CNT_H = 0;
		SampleLength1 = 0;
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
