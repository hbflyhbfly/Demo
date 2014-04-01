//
//  BackGroundLayer.m
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import "BackGroundLayer.h"

@implementation BackGroundLayer

-(id) init
{
	if( (self=[super init]) ) {

        _m_barPies = [NSMutableArray array];
        [_m_barPies retain];
        back = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ground.png"]];
        back.position = ccp(0, 0);
        back.scaleX = 2.0;
        
        [self schedule:@selector(moveBack:) interval:5];
        [self addChild:back];
	}
	return self;
}

-(void)moveBack:(float)dt{
    CGSize size = [[CCDirector sharedDirector] winSize];

    barPipe = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"down_bar.png"]];
    
    barPipe.position =  ccp( size.width, 150 - barPipe.boundingBox.size.height);
    CCMoveTo* move = [CCMoveTo actionWithDuration:10 position:ccp(-barPipe.boundingBox.size.width, barPipe.position.y)];
    CCCallFuncN* moveDone = [CCCallFuncN actionWithTarget:self selector:@selector(removeBarPie:)];
    [barPipe runAction:[CCSequence actions:move,moveDone, nil]];
    [self addChild:barPipe z:-1];
    [_m_barPies addObject:barPipe];
    
}

-(void)setRandomY:(CCSprite*)barPie{
    //int ran = random()%2;

}
-(void)removeBarPie:(CCSprite*)barPie{
    [self removeChild:barPipe];
    [_m_barPies removeObject:barPipe];
}

@end
