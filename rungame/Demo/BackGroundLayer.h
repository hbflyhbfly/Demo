//
//  BackGroundLayer.h
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright 2014年 jytx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BackGroundLayer : CCLayer {
    
}
@property (assign)NSMutableArray* _m_grounds;
-(void)initGround;
-(void)updateGround:(float)dt;
@end
