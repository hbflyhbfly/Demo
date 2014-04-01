//
//  CollisionLayer.m
//  Demo
//
//  Created by zhoufei on 14-4-1.
//  Copyright 2014年 jytx. All rights reserved.
//

#import "CollisionLayer.h"
#import "Header.h"
#define COLLISION_BARPIE_TAG 0
@implementation CollisionLayer

-(id) init
{
	if( (self=[super init]) ) {
        self.zOrder = ZORDER_COLLISION;
        [self initCollision];
	}
	return self;
}
-(void)initCollision{
    __m_barPies = [NSMutableArray array];
    [__m_barPies retain];
    
    float lenth = INTERVAL_COLLISION + WIDTH_COLLISION;
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    int count = ceil(winSize.width/lenth);
    for (int i = 1; i <= count; i++) {
        CCSprite* barPipe = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"down_bar.png"]];
        [barPipe setPosition:ccp(winSize.width+INTERVAL_COLLISION*i, 330 - HEITH_COLLISION)];
        [__m_barPies addObject:barPipe];
        [self addChild:barPipe z:0 tag:COLLISION_BARPIE_TAG];
        
    }
}

-(void)updateCollisions:(float)dt{
    if (![__m_barPies count]) {
        return;
    }
    CCSprite* barPie;
    for (barPie in __m_barPies) {
        [barPie setPosition:ccp(barPie.position.x - BACK_GROUND_SPEED,barPie.position.y)];
    }
    barPie = [__m_barPies objectAtIndex:0];
    if (barPie.position.x <= -WIDTH_COLLISION) {
        [barPie retain];
        CCSprite* lastBarPie = [__m_barPies lastObject];
        [barPie setPosition:ccp(lastBarPie.position.x + INTERVAL_COLLISION + WIDTH_COLLISION, barPie.position.y)];
        [__m_barPies removeObjectAtIndex:0];
        [__m_barPies addObject:barPie];
        [barPie release];
    }
}

-(void)setRandomY:(CCSprite*)barPie{
    //int ran = random()%2;
    
}

-(void)dealloc{
    [super dealloc];
    [__m_barPies release];
}
@end
