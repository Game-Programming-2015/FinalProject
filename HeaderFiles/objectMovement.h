typedef struct moveable_object{
    //Parent sprite //Redundant comment
    pSprite parentSprite;
    
    //Hitbox information
    pHitbox masterHitBox; //A big outer hitbox to check before the hitBoxList for a collision
    pHitbox hitBoxList; //A list of more accurate hitboxes to check
    int hitBoxCount;
    void (*collisionHandler)(int collisionId); //A function that defines how this object should handle collisions
    
    //Movement speeds
    int hSpeed;
    int vSpeed;
    
    //Make this into a linked list so it can be easy to move all sprites around in one swoop
    struct moveable_object *next;
} Moveable;

/*
* moves an object's sprite on the screen according to its hSpeed and vSpeed
* object - object to move
* horizontal - multiplier on horizontal movement. -1 moves left, 0 doesn't move horizontally, 1 moves right
* vertical - multiplier on vertical movement. -1 reverses, 0 doesn't move, 1 keeps the same.
              This is labeled differently than horizontal because of the fact that vSpeed
              will change between positive and negative when the object starts jumping/falling
* return - collision value, if there is a collision
*/
int moveObject(Moveable *object, int horizontal, int vertical,unsigned short* hitmap){
    int i;
    int maxr=0; //Highest collision value, which will be returned and handled elsewhere
    if (horizontal){
        for (i=object->hSpeed;i>0;i--){ //Move horizontally hSpeed number of times
            int r=hitDetection(object,horizontal,0,hitmap); //Make sure you can move
            if (r>maxr) maxr=r; //If you hit something, remember it

            if (!r){
                object->parentSprite->fields.x+=horizontal; //Move left or right
            }
            else break; //If you hit something, stop trying to move
        }
    }
    
    if (vertical){
        for (i=object->vSpeed;i>0;i--){
            int r=hitDetection(object,0,vertical,hitmap);
            if (r>maxr) maxr=r;
            
            if (!r){
                object->parentSprite->fields.y+=vertical;
            }
            else break;
        }
    }
    
    return maxr;
}

int getLocationValue(int x,int y,unsigned short *loc){
    return loc[y/8*32+x/8];
}

int hitDetectionBackground(HitBox hb, unsigned short hOffset,unsigned short vOffset,unsigned short *bgHitMap){
    int xCheck=(hb.parentSprite->fields.x+hb.x+hOffset)%256;
    int yCheck=hb.parentSprite->fields.y+hb.y+vOffset;
    int finalX=xCheck+hb.xSize;
    int finalY=yCheck+hb.ySize;
    int r=0;
    int i=0;

    while (yCheck<finalY){
        while (xCheck<finalX){
            int bgItem=getLocationValue(xCheck,yCheck,bgHitMap);

            if (bgItem>r){
                r=bgItem;
            }
            xCheck+=8;
            i++;
        }
        xCheck=(hb.parentSprite->fields.x+hb.x+hOffset)%256;
        yCheck+=8;
    }

    int bgItem=getLocationValue(finalX,finalY,bgHitMap);
    if (bgItem>r){
        r=bgItem;
    }

    return r;
}

/*
Returns the highest hit detection
This is really bad. The concept is that the highest collision number for a hitbox is returned, so there can be priority, but...
I can only see this causing problems. This is going to make things more difficult, I'm sure.
But I don't know what the other choice is? Like, I need someone else to look at how to organize everything
because I can't figure out the best way to do it.

...anyway
* object - pointer to a moveable object that is to be collision detected
* hOffset - horizontal offset to use with the hitbox
* vOffset - vertical offset
* hitmap - the background with collision data attached
*/
int hitDetection(Moveable *object,int hOffset,int vOffset,unsigned short* hitmap){
    int r=0;
    if ( hitDetectionBackground((*object->masterHitBox),hOffset,vOffset,hitmap) ){ //If the big hitbox finds something
        int i;
        //Check all the smaller hitboxes
        HitBox currenthb = (*object->hitBoxList); //Grab the first hitbox in the list
        
        for (i=0;i<object->hitBoxCount;i++){
            int hitValue = hitDetectionBackground(currenthb,hOffset,vOffset,hitmap);//Grab the max collision for the current hitbox
            if (hitValue>r) //If it's higher than the current, use it instead.
                r = hitValue;
        }
        
    }
    
    //(object->collisionHandler)(r);
    
    spritePal[255]=r;
    
    return r;
}

void gravityControls(Moveable *object){
    return;
}
