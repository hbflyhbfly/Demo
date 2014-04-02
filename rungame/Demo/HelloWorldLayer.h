//
//  HelloWorldLayer.h
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright jytx 2014年. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "BackGroundLayer.h"
#import "RunerLayer.h"
#import "CollisionLayer.h"
#import "RunerLayer.h"
#import "cocos2d.h"
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    BackGroundLayer* backGroundLayer;
    CollisionLayer* collisionLayer;
    RunerLayer* runerLayer;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)checkCollision;
@end
