//
//  SimpleButton.h
//  BEHGame
//
//  Created by Jack Lor on 05/02/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class SimpleButton;

@interface SimpleButton : CCSprite <CCTargetedTouchDelegate>
{
    float _radius;
}

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) NSDictionary *selectors;
@property BOOL isHeld;

+(id)buttonWithFile:(NSString *)fileName radius:(float)radius selectors:(NSDictionary *)selects;
-(id)initWithFile:(NSString *)filename radius:(float)radius selectors:(NSDictionary *)selects;

@end
