//
//  RunerLayer.m
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import "RunerLayer.h"
#import "Header.h"
#include <Box2D.h>

const float CONST_SPEED_Y = 9;

@implementation RunerLayer

-(id)initRunerWith:(b2World*)world{
    if( (self=[super init])) {
        
        self.zOrder = ZORDER_RUNER;
        _speedY = 0;
        _grivate = GRIVATE;
        _groundHeigh = BACK_GROUND_HEIGH;
        _world = world;
    
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
    //物理体
        b2BodyDef ballBodyDef;
        ballBodyDef.type = b2_staticBody;
        ballBodyDef.position.Set(__runner.position.x/PTM_RATIO, __runner.position.y/PTM_RATIO);
        ballBodyDef.userData = __runner;
        _runer_body = world->CreateBody(&ballBodyDef);
        
        b2CircleShape circle;
        circle.m_radius =26.0/PTM_RATIO;
        
        b2FixtureDef ballShapeDef;
        ballShapeDef.shape =&circle;
        ballShapeDef.density =1.0f;
        ballShapeDef.friction =0.2f;
        ballShapeDef.restitution =0.8f;
        ballShapeDef.isSensor =true;
        _runer_body->CreateFixture(&ballShapeDef);
    }
    return self;
}

- (void)tick:(ccTime) dt {
    
    _world->Step(dt, 10, 10);
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (CCSprite *)b->GetUserData();
//            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
//                                    b->GetPosition().y * PTM_RATIO);
//            ballData.rotation =-1* CC_RADIANS_TO_DEGREES(b->GetAngle());
            b2Vec2 b2Position = b2Vec2(ballData.position.x/PTM_RATIO,
                                       ballData.position.y/PTM_RATIO);
            float32 b2Angle =-1* CC_DEGREES_TO_RADIANS(ballData.rotation);
            
            b->SetTransform(b2Position, b2Angle);
        }
    }
    
}

-(void)updateRuner:(float)dt{
    [self tick:dt];
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
        bRet = YES;
        NSLog(@"bottom");
    }
    if (collArea) {
        [self fixCollision:collArea withLocation:location];
    }
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
            [__runner setPosition:ccpAdd(location, ccp(0, -1))];
            break;
        case COLL_STATE_BOTTOM:
            [__runner setPosition:ccpAdd(location, ccp(0, 1))];
            
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


-(void)dealloc{
    delete _world;
    _runer_body = NULL;
    _world = NULL;
    [super dealloc];
}
@end
