typedef struct hitBox{
    int x;
    int y;
    int xSize;
    int ySize;
    pSprite parentSprite;
} HitBox, *pHitbox;

typedef struct moveable_object{
    pSprite parentSprite;
    
    //Hitbox information
    pHitbox masterHitBox; //A big outer hitbox to check before the hitBoxList for a collision
    pHitbox hitBoxList; //A list of more accurate hitboxes to check
    int hitBoxCount;
    int (*collisionHandler)(int collisionId,struct moveable_object *self); //A function that defines how this object should handle collisions
    
    //Movement speeds
    int hSpeed;
    int vSpeed;
    
    //Make this into a linked list so it can be easy to move all sprites around in one swoop
    //I think this will be easier than an array, but feel free to pitch me reasons why not.
    struct moveable_object *next;
} Moveable;

int moveObject(Moveable *object, unsigned int horizontal, unsigned int vertical,unsigned short* hitmap,int hOffset,int vOffset);
inline int getLocationValue(int x,int y,unsigned short *bg);
int hitDetectionBackground(HitBox hb, unsigned short hOffset,unsigned short vOffset,unsigned short *bgHitMap,Moveable *parentObject,int doCollisions);
int hitDetection(Moveable *object,int hOffset,int vOffset,unsigned short* hitmap);
void gravityControls(Moveable *object,int hOffset,int vOffset,unsigned short* bgHitMap);
int playerCollisionHandler(int collisionID,Moveable *self);

/*
* moves an object's sprite on the screen according to its hSpeed and vSpeed
* object - object to move
* horizontal - multiplier on horizontal movement.
* vertical - multiplier on vertical movement.
* return - collision value, if there is a collision
*/
int moveObject(Moveable *object, unsigned int horizontal, unsigned int vertical,unsigned short* hitmap,int hOffset,int vOffset){
    int i;

    if (horizontal){
        //Get the direction the object is moving
        int horizontalSign=(object->hSpeed<0)?-1:(object->hSpeed>0);
        
        for (i=object->hSpeed*horizontal;i!=0;i-=horizontalSign){ //Move horizontally abs(hSpeed*horizontal) number of times
            int r=hitDetection(object,horizontalSign+hOffset,0+vOffset,hitmap); //Make sure you can move
            
            if (!r){
                object->parentSprite->fields.x+=horizontalSign; //Move left or right
            }
            else break; //If you hit something, stop trying to move
        }
    }

    //This is pretty similar to horizontal
    if (vertical){
        int verticalSign=(object->vSpeed<0)?-1:(object->vSpeed>0);
        for (i=object->vSpeed*vertical;i!=0;i-=verticalSign){
            int r=hitDetection(object,0+hOffset,verticalSign+vOffset,hitmap);
            
            if (!r){
                object->parentSprite->fields.y+=verticalSign;
            }
            else break;
        }
    }
    
    return 0;
}

inline int getLocationValue(int x,int y,unsigned short *bg){
    return bg[y/8*32+x/8];
}

//Detect if there was a collision with the background
int hitDetectionBackground(HitBox hb, unsigned short hOffset,unsigned short vOffset,unsigned short *bgHitMap,Moveable *parentObject,int doCollisions){
    int xCheck=(hb.parentSprite->fields.x+hb.x+hOffset)%256; //The leftmost position of the hitbox
    int yCheck=(hb.parentSprite->fields.y+hb.y+vOffset)%256; //The topmost position of the hitbox
    //The bottom right of the hitbox
    int finalX=xCheck+hb.xSize;
    int finalY=yCheck+hb.ySize;
    //Tells if we're done in each respective axis
    int yDone,xDone;
    
    int r=0; //A return value if it needs to be handled by the caller
    
    yDone=xDone=0;
    
    //Check every 8 pixels around the edge of the hitbox
    while (yDone!=2){ //2 because we have to make one last check after we reach the edge so that the edge is actually checked
        while (xDone!=2){
            //Get the background tile at the current location
            int bgItem=getLocationValue(xCheck,yCheck,bgHitMap);
            
            //Take care of any collisions that happen, if the flag is set to do them
            if (doCollisions)
                bgItem=(parentObject->collisionHandler)(bgItem,parentObject);
            
            //If the collision handler returned a non-zero, we'll want to return the highest value to the handler
            if (bgItem>r){
                r=bgItem;
            }
            //Go to the next x position
            xCheck+=8;
            
            //If we finished the horizontal line last time, tell the loop to quit
            if (xDone==1)
                xDone=2;
            else if (xCheck>=finalX){ //If we're at the right edge and we're not done, check the right edge
                xCheck=finalX;
                xDone=1; 
            }
        }
        //Reset the x position
        xCheck=(hb.parentSprite->fields.x+hb.x+hOffset)%256;
        xDone=0;
        //Go to the next y position
        yCheck+=8;
        
        //If we finished last time, tell the loop to quit
        if (yDone==1)
            yDone=2;
        else if (yCheck>=finalY){ //If we're at the bottom edge, and we're not done, check the bottom edge
            yCheck=finalY;
            yDone=1;
        }
    }
    return r;
}

/*
Takes care of collisions. Returns the highest collision value it couldn't take care of.

* object - pointer to a moveable object that is to be collision detected
* hOffset - horizontal offset to use with the hitbox
* vOffset - vertical offset
* hitmap - the background with collision data attached
*/

int hitDetection(Moveable *object,int hOffset,int vOffset,unsigned short* hitmap){
    int r=0;
    //If the big hitbox finds something
    if ( hitDetectionBackground((*object->masterHitBox),hOffset,vOffset,hitmap,object,0) ){
        int i;
        //Check all the smaller hitboxes
        HitBox currenthb = (*object->hitBoxList); //Grab the first hitbox in the list
        
        for (i=0;i<object->hitBoxCount;i++){
            //Grab the max collision for the current hitbox
            int hitValue = hitDetectionBackground(currenthb,hOffset,vOffset,hitmap,object,1);
            if (hitValue>r) //If it's higher than the current, use it instead.
                r = hitValue;
        }
    }
    /*
    if ( hitDetectionSprites((*object->masterHitbox),hOffset,vOffset,hitmap,object,0) ){
    }
    */
    
    return r;
}

void gravityControls(Moveable *object,int hOffset,int vOffset,unsigned short* bgHitMap){
    if (!hitDetection(object,hOffset,vOffset+1,bgHitMap)){
        object->vSpeed++;
    }
    else if (object->vSpeed>0){
        object->vSpeed=0;
    }
}



int playerCollisionHandler(int collisionID,Moveable *self){
    int r=0;
    switch (collisionID){
        case 0:
            r=0;
            break;
        case 1: //blue
            r=mainColor==blueMain;
            break;
        case 2: //violet
            r=mainColor==violetMain;
            break;
        case 3: //red
        case 0x0403: //This is the flipped version of the tile, which is apparently a thing you can do
            r=mainColor==redMain;
            break;
        case 4: //green
            r=mainColor==greenMain;
            break;
        default :
            r=1;
            break;
    }
    
    return r;
}
