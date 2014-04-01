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
		//背景
        backGroundLayer = [BackGroundLayer node];
		[self addChild:backGroundLayer];
        //女娃
        runerLayer = [RunerLayer node];
        [self addChild:runerLayer];
        //障碍物
        collisionLayer = [CollisionLayer node];
        [self addChild:collisionLayer];

	}
    [self scheduleUpdate];
    [self setTouchEnabled:YES];
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    if (![runerLayer isJump]) {
        [runerLayer setRunerStatu:JUMP_UP];
    }
    return true;
}

-(void)update:(ccTime)delta{
    [backGroundLayer updateGround:delta];
    [runerLayer updateRuner:delta];
    [collisionLayer updateCollisions:delta];
    [self checkCollision];
    
}

-(void)checkCollision{
    for (CCSprite* collision in collisionLayer._m_barPies) {
        CGRect bigCollRect = collision.boundingBox;
        CGRect collRect = CGRectMake(bigCollRect.origin.x, 300-bigCollRect.size.height, bigCollRect.size.width, 300);
        [runerLayer isCollision:bigCollRect];
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
