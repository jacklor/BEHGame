//
//  InfiniteModeLayer.h
//  BEHGame
//
//  Created by Jack Lor on 28/01/13.
//
//

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCLayer.h"
#import "Gack.h"
#import "SimpleDPad.h"
#import "Damaging.h"

@interface InfiniteModeLayer : CCLayer <SimpleDPadDelegate>
{
    Gack *gack;
    NSMutableArray *boidList;
    Damaging *shield;
}
@end
