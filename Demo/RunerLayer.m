//
//  RunerLayer.m
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import "RunerLayer.h"


@implementation RunerLayer

-(id) init
{
	if( (self=[super init])) {
        
        speed = 0;
        grivate = GRIVATE;
        constSpeed = 10;
        _runner = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"loading_01.png"]];
        _runner.position = ccp(100, 25);
        _runner.anchorPoint = ccp(0, 0);
        _runner.scale = 0.5;
        NSMutableArray *animFrames = [NSMutableArray array];
        char str[64] = {0};
        for (int i = 1; i <= 12; ++i) {
            sprintf(str, "loading_%02d.png", i);
            // 添加帧到数组
            [animFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithUTF8String:str]]];
        }
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.04];          // 添加帧到数组
        CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
        [_runner runAction:[CCRepeatForever actionWithAction:animate]];
        [self addChild:_runner];
    }
	return self;
}

-(void)jump{
    switch (runerStatu) {
            case JUMP_UP: {
                
                [self roleJumpUpLogic];
                break;
            }
            case JUMP_DOWN: {
                [self roleJumpDownLogic];
                
                break;
            }
            case NORMAL: {
                //[self roleJumpDownLogic];
                
                break;
            }

        default:
            break;
    }
}

-(void)setRunerStatu:(RUNER_STATU)statu{
    
    switch (statu) {
            case JUMP_UP:
            [self setSpeedY:constSpeed];
            break;
            case JUMP_DOWN:
            [self setSpeedY:0];
            break;
            case NORMAL:
            [self setSpeedY:0];
            break;
            
        default:
            break;
    }
    runerStatu = statu;
    
}

-(void) roleJumpDownLogic {
    
    float roleY = _runner.position.y;
    roleY -= speed;
    if (roleY < 200) {
        return;
    }
    
    [_runner setPosition:ccp(_runner.position.x, roleY)];
    [self setSpeedY:speed+grivate];
}

-(void) roleJumpUpLogic {
    
    float roleY = _runner.position.y;
    roleY += speed;
    if (roleY < 200) {
        return;
    }
    
    [_runner setPosition:ccp(_runner.position.x, roleY)];
    [self setSpeedY:speed-grivate];
}

-(void)setSpeedY:(float)speed{
    
}
@end
