//
//  BackGroundLayer.m
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import "BackGroundLayer.h"
#import "Header.h"
@implementation BackGroundLayer

-(id) init
{
	if( (self=[super init]) ) {

        self.zOrder = ZORDER_GROUND;
        [self initGround];
        //[self schedule:@selector(moveBack:) interval:5];
        //[self addChild:back];
	}
	return self;
}
-(void)initGround{
    __m_grounds = [NSMutableArray array];
    [__m_grounds retain];
    for (int i = 0; i < 3; i++) {
        CCSprite* ground = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ground.png"]];
        [ground setPosition:ccp(ground.boundingBox.size.width*i, 0)];;
        [ground setAnchorPoint:ccp(0, 0)];
        [__m_grounds addObject:ground];
        [self addChild:ground];
    }
}

-(void)updateGround:(float)dt{
    CCSprite* ground;
    for (ground in __m_grounds) {
        [ground setPosition:ccp(ground.position.x -BACK_GROUND_SPEED, ground.position.y)];
    }
    ground = [__m_grounds objectAtIndex:0];
    
    if (ground.position.x<=-ground.boundingBox.size.width) {
        [ground retain];
        [ground setPosition:ccp(ground.boundingBox.size.width*2, ground.position.y)];
        [__m_grounds removeObjectAtIndex:0];
        [__m_grounds addObject:ground];
        [ground release];
    }
}


-(void)dealloc{
    [super dealloc];
    [__m_grounds release];
}
@end
