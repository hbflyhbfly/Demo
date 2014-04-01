//
//  RunerLayer.m
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import "RunerLayer.h"
#import "Header.h"
const float CONST_SPEED_Y = 9;

@implementation RunerLayer

-(id) init
{
	if( (self=[super init])) {
        
        self.zOrder = ZORDER_RUNER;
        _speedY = 0;
        _grivate = GRIVATE;
        [self initRuner];
        _groundHeigh = BACK_GROUND_HEIGH;
        
    }
	return self;
}

-(void)initRuner{
    __runner = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"loading_01.png"]];
    __runner.position = ccp(100, _groundHeigh);
    __runner.anchorPoint = ccp(0, 0);
    [self setRunerStatu:NORMAL];
    __runner.scale = 0.5;
    NSMutableArray *animFrames = [NSMutableArray array];
    char str[64] = {0};
    for (int i = 1; i <= 12; ++i) {
        sprintf(str, "loading_%02d.png", i);
        // 添加帧到数组
        [animFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithUTF8String:str]]];
    }
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.04];          // 添加帧到数组
    CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
    [__runner runAction:[CCRepeatForever actionWithAction:animate]];
    [self addChild:__runner];
}

-(void)updateRuner:(float)dt{
    switch (_runerStatu) {
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
            [self setSpeedY:CONST_SPEED_Y];
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
    _runerStatu = statu;
    
}

-(void) roleJumpDownLogic {
    
    float roleY = __runner.position.y;
    roleY += [self getSpeedY];
    [__runner setPosition:ccp(__runner.position.x, roleY)];
    [self setSpeedY:[self getSpeedY] - _grivate];
    if (roleY <= _groundHeigh) {
        [__runner setPosition:ccp(__runner.position.x, _groundHeigh)];
        [self setRunerStatu:NORMAL];
        return;
    }

}

-(void) roleJumpUpLogic {
    
    float roleY = __runner.position.y;
    roleY += _speedY;

    [__runner setPosition:ccp(__runner.position.x, roleY)];
    [self setSpeedY:[self getSpeedY]-_grivate];
    if ([self getSpeedY]<=0) {
        [self setRunerStatu:JUMP_DOWN];
        return;
    }
}

-(void)roleNormalLogic{
    float roleY = __runner.position.y;
    roleY += [self getSpeedY];
    [__runner setPosition:ccp(__runner.position.x, roleY)];
    [self setSpeedY:[self getSpeedY]- _grivate];
    if (roleY <= _groundHeigh) {
        [__runner setPosition:ccp(__runner.position.x, _groundHeigh)];
        [self setRunerStatu:NORMAL];
        //_groundHeigh = BACK_GROUND_HEIGH;
        return;
    }

}

-(void)toGround{
    
}

-(BOOL)isCollision:(CGRect)coll{
    BOOL bRet = NO;
    CGRect runerRect = __runner.boundingBox;
    CGPoint location = __runner.position;
    COLL_AREA collArea;
    //left
    if (CGRectContainsPoint(coll, ccpAdd(location, ccp(0, runerRect.size.height/2)))) {
        collArea = COLL_STATE_LEFT;
        bRet = YES;
        NSLog(@"left");
    }
    //right
    if (CGRectContainsPoint(coll, ccpAdd(location, ccp(runerRect.size.width, runerRect.size.height/2)))) {
        collArea = COLL_STATE_RIGHT;
        bRet = YES;
        NSLog(@"right");
    }
    //up
    if (CGRectContainsPoint(coll, ccpAdd(location, ccp(runerRect.size.width/2, runerRect.size.height)))) {
        collArea = COLL_STATE_UP;
        bRet = YES;
        NSLog(@"up");
    }
    //bottom
    if (CGRectContainsPoint(coll, ccpAdd(location, ccp(runerRect.size.width/2, 0)))) {
        collArea = COLL_STATE_BOTTOM;
        _groundHeigh = location.y;
        [self setRunerStatu:NORMAL];
        bRet = NO;
        NSLog(@"bottom");
    }
    //if (collArea) {
    //    [self fixCollision:collArea withLocation:location];
    //}
    return bRet;
    
}

-(void)fixCollision:(COLL_AREA)collisionArea withLocation:(CGPoint)location{
    switch (collisionArea) {
        case COLL_STATE_LEFT:
            [__runner setPosition:ccpAdd(location, ccp(1, 0))];
            break;
        case COLL_STATE_RIGHT:
            [__runner setPosition:ccpAdd(location, ccp(-1, 0))];
            break;
        case COLL_STATE_UP:
            [__runner setPosition:ccpAdd(location, ccp(0, 1))];
            break;
        case COLL_STATE_BOTTOM:
            //[__runner setPosition:ccpAdd(location, ccp(0, -1))];
            
            break;
            
        default:
            break;
    }
}

-(void)setSpeedY:(float)speed{
    _speedY = speed;
}
-(float)getSpeedY{
    return _speedY;
}

-(RUNER_STATU)getRunerStatu{
    return _runerStatu;
}
-(BOOL)isJump{
    return (!([self getRunerStatu] == NORMAL));
}
@end
