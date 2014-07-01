//
//  Entity.m
//  BEHGame
//
//  Created by Jack Lor on 28/01/13.
//
//

#import "Entity.h"
#import "Globals.h"

@implementation Entity

@synthesize pos;
@synthesize life, size, maxSpeed;
@synthesize type;

- (id)initWithPos:(Vector3D *)loc type:(NSString *)t size:(float)s fileName:(NSString *)str
{
    self = [super initWithFile:str];
    if (self)
    {        
        NSNumber *zOrder = [[[Globals getGlobals] zOrderList] objectForKey:t];
        self.zOrder =  zOrder.intValue;
        
        pos = loc;
        type = t;
        size = s;
        life = 1;
        [self setPosition:ccp(pos.x, pos.y)];
    }
    return self;
}

- (void)update
{
    [self setPosition:ccp(pos.x, pos.y)];
}

@end
