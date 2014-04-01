//
//  RunerLayer.h
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#include <Box2D.h>
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
    b2Body *_runer_body;
    b2World *_world;
}
@property (assign) CCSprite* _runner;
-(id)initRunerWith:(b2World*)world;
-(void)updateRuner:(float)dt;
-(void)setRunerStatu:(RUNER_STATU)statu;
-(RUNER_STATU)getRunerStatu;
-(void)setSpeedY:(float)speed;
-(float)getSpeedY;
-(void)roleJumpDownLogic;
-(void)roleJumpUpLogic;
-(BOOL)isJump;
-(BOOL)isCollision:(CGRect)coll;
-(void)fixCollision:(COLL_AREA)collisionArea withLocation:(CGPoint)location;
- (void)tick:(ccTime) dt;
@end
