//
//  ThornShield.m
//  BEHGame
//
//  Created by Jack Lor on 06/02/13.
//
//

#import "ThornShield.h"
#import "Globals.h"

@implementation ThornShield

@synthesize parent;

- (id)initWithPos:(Vector3D *)loc target:(id)tar
{
    self = [super initWithPos:loc size:20.f fileName:@"thornball.png" damage:4.5f target:tar];
    
    if (self)
    {        
        NSNumber *zOrder = [[[Globals getGlobals] zOrderList] objectForKey:@"shieldEffect"];
        self.zOrder =  zOrder.intValue;
        self.scale = 2.f;
        
        shieldRotation = 0;
    }
    return self;
}

- (void)update
{
    shieldRotation += [[[Globals getGlobals] gack] maxSpeed] * 1.3f;
    if (shieldRotation > 360)
        shieldRotation -= 360;
    [self setRotation:shieldRotation];
    
    [super update];
    
}

@end
