//
//  Globals.m
//  BEHGame
//
//  Created by Jack Lor on 04/02/13.
//
//

#import "Globals.h"

@implementation Globals

@synthesize gameHeight, gameWidth;
@synthesize zOrderList;
@synthesize gack;

+(Globals *)getGlobals
{
    static Globals *globals = nil;
    
    if (!globals)
        globals = [[Globals alloc] init];
    return globals;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        gameWidth = screenSize.height;
        gameHeight = screenSize.width;
    
        zOrderList = [[NSMutableDictionary alloc] init];
        
        [zOrderList setObject:[[NSNumber alloc] initWithInt:0] forKey:@"background"];
        [zOrderList setObject:[[NSNumber alloc] initWithInt:0] forKey:@"button"];
        [zOrderList setObject:[[NSNumber alloc] initWithInt:0] forKey:@"bgEffect"];
        [zOrderList setObject:[[NSNumber alloc] initWithInt:0] forKey:@"shieldEffect"];
        [zOrderList setObject:[[NSNumber alloc] initWithInt:0] forKey:@"enemy"];
        [zOrderList setObject:[[NSNumber alloc] initWithInt:0] forKey:@"damaging"];
        [zOrderList setObject:[[NSNumber alloc] initWithInt:0] forKey:@"player"];
        
        int i = 0;
        for (NSString *zOrder in [zOrderList allKeys])
        {
            [zOrderList setObject:[[NSNumber alloc] initWithInt:i] forKey:zOrder];
            i++;
        }
    }
    return self;
}

@end
