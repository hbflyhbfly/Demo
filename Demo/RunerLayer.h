//
//  RunerLayer.h
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//runer状态
typedef enum{
    NORMAL,
    JUMP_UP,
    JUMP_DOWN
} RUNER_STATU;
#define GRIVATE 9.8
@interface RunerLayer : CCLayer {
    float grivate;
    float speed;
    float constSpeed;
    RUNER_STATU runerStatu;
}
@property (assign) CCSprite* runner;
-(void)jump;
-(void)setRunerStatu:(RUNER_STATU)statu;
-(void)setSpeedY:(float)speed;
-(void)roleJumpDownLogic;
-(void)roleJumpUpLogic;

@end
