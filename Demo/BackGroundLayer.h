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
    CCSprite *barPipe;
    CCSprite *back;
    

}
@property (assign)NSMutableArray* m_barPies;
-(void)moveBack:(float)dt;
-(void)removeBarPie:(CCSprite*)barPie;
-(void)setRandomY:(CCSprite*)barPie;
@end
