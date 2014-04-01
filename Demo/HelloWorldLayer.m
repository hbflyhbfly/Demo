//
//  HelloWorldLayer.m
//  Demo
//
//  Created by zhoufei on 14-3-31.
//  Copyright jytx 2014年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{

	if( (self=[super init]) ) {
		
        backGroundLayer = [BackGroundLayer node];
		[self addChild:backGroundLayer];
        runerLayer = [RunerLayer node];
        [self addChild:runerLayer];

	}
    [self scheduleUpdate];
    [self setTouchEnabled:YES];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"shoot_background.plist"];
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    [runerLayer setRunerStatu:JUMP_UP];
    [runerLayer jump];
    return true;
}

-(void)update:(ccTime)delta{
    [self updateCollisions];
}

-(void)updateCollisions{
    for (int i = 0;i<backGroundLayer.m_barPies.count;i++) {
        CCSprite* collisionBar = [backGroundLayer.m_barPies objectAtIndex:i];
        //collisionBar.boundingBox
        if (CGRectIntersectsRect(collisionBar.boundingBox, runerLayer.runner.boundingBox)) {
            NSLog(@"碰撞了");
        }
    }
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
