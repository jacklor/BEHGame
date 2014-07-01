//
//  Globals.h
//  BEHGame
//
//  Created by Jack Lor on 04/02/13.
//
//

#import <Foundation/Foundation.h>
#import "Gack.h"

@interface Globals : NSObject
{
    
}

@property (nonatomic, strong) NSMutableDictionary *zOrderList;
@property int gameWidth;
@property int gameHeight;

@property (nonatomic, assign) Gack* gack;

+(Globals *)getGlobals;

@end
