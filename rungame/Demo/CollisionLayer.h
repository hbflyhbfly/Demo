//
//  CollisionLayer.h
//  Demo
//
//  Created by zhoufei on 14-4-1.
//  Copyright 2014年 jytx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CollisionLayer : CCLayer {
    
}
@property (assign)NSMutableArray* _m_barPies;
-(void)updateCollisions:(float)dt;
@end
