//
//  InfiniteModeLayer.m
//  BEHGame
//
//  Created by Jack Lor on 28/01/13.
//
//

#import "InfiniteModeLayer.h"
#import "cocos2d.h"
#import "Globals.h"
#import "SimpleButton.h"
#import "Boid.h"
#import "ThornShield.h"

@implementation InfiniteModeLayer
// Helper class method that creates a Scene with the InfiniteModeLayer as the only child.

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        gack = [[Gack alloc] init];
        [[Globals getGlobals] setGack:gack];
        
		[self schedule:@selector(update:)];        
        [self addChild:gack];
        boidList = [[NSMutableArray alloc] init];
        for (int i = 0; i < 25; i++)
        {
            Boid *boid = [[Boid alloc] initWithPos:
                          [[Vector3D alloc] initWithAxeX:rand() % [Globals getGlobals].gameWidth
                                                    axeY:rand() % [Globals getGlobals].gameHeight]];
            boid.boidList = boidList;
            [boidList addObject:boid];
            
            [self addChild:boid];
        }
        
        shield = [[ThornShield alloc] initWithPos:[gack pos] target:boidList];
        [self addChild:shield];
        
    }
	return self;
}

#pragma - mark DPad callbacks

-(void)simpleDPad:(SimpleDPad *)simpleDPad didChangeDirectionTo:(CGPoint)direction
{
    [gack.acc add:[[Vector3D alloc] initWithAxeX:direction.x axeY:direction.y]];
}

-(void)simpleDPad:(SimpleDPad *)simpleDPad isHoldingDirection:(CGPoint)direction
{
    [gack.acc add:[[Vector3D alloc] initWithAxeX:direction.x axeY:direction.y]];
}

-(void)simpleDPadTouchEnded:(SimpleDPad *)simpleDPad
{
}

#pragma - mark Right Button callbacks

- (void)rightButtonStarted:(SimpleButton *)button
{
    [gack accelerateStart];    
}

- (void)rightButtonIsHolding:(SimpleButton *)button
{
    //gack.dec = [[Vector3D alloc] initWithAxeX:gack.vel.x axeY:gack.vel.y];
}

- (void)rightButtonEnded:(SimpleButton *)button
{
    [gack accelerateEnd];
}

#pragma - mark Main game cycle


- (void)update:(ccTime)dt {
    [gack update];
    for (int i = boidList.count - 1; i > 0; i--)
    {
        Boid *boid = [boidList objectAtIndex:i];
        if (gack.life > 0)
            [boid seek:gack.pos];
        [boid update];
        if (boid.life <= 0)
        {
            [self removeChild:boid cleanup:YES];
            [boidList removeObject:boid];
        }
    }
    for (int i = boidList.count; i < 25; i++)
    {
        Boid *boid = [[Boid alloc] initWithPos:
                      [[Vector3D alloc] initWithAxeX:rand() % [Globals getGlobals].gameWidth
                                                axeY:rand() % [Globals getGlobals].gameHeight]];
        boid.boidList = boidList;
        [boidList addObject:boid];
        
        [self addChild:boid];
    }
    [shield update];
}

@end
