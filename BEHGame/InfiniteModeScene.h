//
//  InfiniteModeScene.h
//  BEHGame
//
//  Created by Jack Lor on 30/01/13.
//
//

#import "CCScene.h"
#import <GameKit/GameKit.h>

#import "InfiniteModeLayer.h"
#import "cocos2d.h"
#import "CCLayer.h"

@interface InfiniteModeScene : CCScene
{
    InfiniteModeLayer *gameLayer;
}
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
