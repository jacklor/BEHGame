//
//  InfiniteModeScene.m
//  BEHGame
//
//  Created by Jack Lor on 30/01/13.
//
//

#import "InfiniteModeScene.h"
#import "SimpleButton.h"
#import "Globals.h"

@implementation InfiniteModeScene
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [[InfiniteModeScene alloc] init];
	
	// return the scene
	return scene;
}

- (id)init {
    
    if ((self = [super init])) {
        gameLayer = [InfiniteModeLayer node];
        gameLayer.isTouchEnabled = YES;
        // Left Game Pad        
        SimpleDPad *gamePad = [SimpleDPad dPadWithFile:@"pd_dpad.png" radius:64];
        gamePad.position = ccp(64.0, 64.0);
        gamePad.opacity = 75;
        gamePad.delegate = gameLayer;
        [self addChild:gamePad];
        
        // Right Button         
        NSDictionary *selectors = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   @"rightButtonStarted:", @"started",
                                   @"rightButtonIsHolding:", @"holding",
                                   @"rightButtonEnded:", @"ended",
                                   nil];        
        SimpleButton *rightButton = [SimpleButton buttonWithFile:@"Icon-Small.png" radius:50 selectors:selectors];
        NSLog(@"global %d", [Globals getGlobals].gameWidth);
        rightButton.position = ccp([Globals getGlobals].gameWidth - 64.0, 64.0);
        rightButton.opacity = 100;
        rightButton.scale = 2.0;
        rightButton.delegate = gameLayer;     
        [self addChild:rightButton];        
        
        [self addChild:gameLayer];
    }
	
	return self;
}

@end
