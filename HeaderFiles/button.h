#define REG_BUTTON (volatile unsigned short*)0x4000130
#define BTN_A 0x1
#define BTN_B 0x2
#define BTN_SELECT 0x4
#define BTN_START 0x8
#define BTN_RIGHT 0x10
#define BTN_LEFT 0x20
#define BTN_UP 0x40
#define BTN_DOWN 0x80
#define BTN_R 0x100
#define BTN_L 0x200

unsigned short prevButton=~0;
unsigned short currButton=~0;

void pollButtons(){
    prevButton=currButton;
    currButton=~(*REG_BUTTON);
}

int checkPressed(int button){
    return currButton & button && !(prevButton & button);
}

int checkHeld(int button){
    return currButton & button && prevButton & button;
}

int checkReleased(int button){
    return !(currButton & button) && prevButton & button;
}

int checkHeldReleased(int button){
    return !(currButton & button) && !(prevButton & button);
}

int checkState(int button){
    return currButton & button;
}

/*
void setButtonState(int buttons[10],int button,int state){
    int i;
    switch (button){
        case BTN_A:
            i=0;
            break;
        case BTN_B:
            i=1;
            break;
        case BTN_SELECT:
            i=2;
            break;
        case BTN_START:
            i=3;
            break;
        case BTN_RIGHT:
            i=4;
            break;
        case BTN_LEFT:
            i=5;
            break;
        case BTN_UP:
            i=6;
            break;
        case BTN_DOWN:
            i=7;
            break;
        case BTN_R:
            i=8;
            break;
        case BTN_L:
            i=9;
            break;
        default:
            return;
    }
    buttons[i]=state;
}*/
