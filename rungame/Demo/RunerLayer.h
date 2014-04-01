//
//  RunerLayer.h
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum{
    NORMAL,
    JUMP_UP,
    JUMP_DOWN
} RUNER_STATU;
typedef enum{
    COLL_STATE_LEFT,
    COLL_STATE_RIGHT,
    COLL_STATE_UP,
    COLL_STATE_BOTTOM
}COLL_AREA;
@interface RunerLayer : CCLayer {
    float _grivate;
    float _speedY;
    RUNER_STATU _runerStatu;
    float _groundHeigh;
}
@property (assign) CCSprite* _runner;
-(void)initRuner;
-(void)updateRuner:(float)dt;
-(void)setRunerStatu:(RUNER_STATU)statu;
-(RUNER_STATU)getRunerStatu;
-(void)setSpeedY:(float)speed;
-(float)getSpeedY;
-(void)roleJumpDownLogic;
-(void)roleJumpUpLogic;
-(void)roleNormalLogic;
-(BOOL)isJump;
-(BOOL)isCollision:(CGRect)coll;
-(void)fixCollision:(COLL_AREA)collisionArea withLocation:(CGPoint)location;
@end
