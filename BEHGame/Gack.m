//
//  Gack.m
//  BEHGame
//
//  Created by Jack Lor on 04/02/13.
//
//

#import "Gack.h"
#import "Globals.h"

@implementation Gack

@synthesize vel, dec, acc;

- (id)init
{
    self = [super initWithPos:[[Vector3D alloc] initWithAxeX:150 axeY:150] type:@"player" size:10.0 fileName:@"gack.png"];
    
    if (self)
    {
        self.life = 100;
        accelerating = NO;
        self.maxSpeed = 4.0f;
        vel = [[Vector3D alloc] initWithAxeX:0 axeY:0];
        acc = [[Vector3D alloc] initWithAxeX:0 axeY:0];
        dec = [[Vector3D alloc] initWithAxeX:0 axeY:0];
        self.scale = 2.2f;
    }
    
    return self;
}

#pragma - mark Update

- (void)baseMovement
{
    [vel add:acc];
    
    [vel limit:self.maxSpeed];
    [dec mult:0.89f];
    [vel add:dec];
    [self.pos add:vel];
    
    [acc setZero];
    
    [vel mult:0.96f];
}

- (void)render
{    
    float theta = CC_RADIANS_TO_DEGREES([vel heading2D]) + 90;
    
    self.rotation = theta;
}

- (void)borders
{
    if (self.pos.x < -self.size)
        self.pos.x = [Globals getGlobals].gameWidth + self.size;
    
    if (self.pos.y < -self.size)
        self.pos.y = [Globals getGlobals].gameHeight + self.size;
    
    if (self.pos.x > [Globals getGlobals].gameWidth + self.size) self.pos.x = - self.size;
    
    if (self.pos.y > [Globals getGlobals].gameHeight + self.size) self.pos.y = - self.size;
}


- (void)update
{
    //
    [self baseMovement];
    
    //
    [self borders];
    [self render];
    
    [super update];
}

#pragma - movement Calls

- (void)accelerateStart
{    
    self.maxSpeed = 10.0f;
    accelerating = YES;
}   

- (void)accelerateEnd
{    
    self.dec = [[Vector3D alloc] initWithAxeX:self.vel.x axeY:self.vel.y];
    self.maxSpeed = 4.0f;
    accelerating = NO;
}

#pragma - interaction Calls

- (void)getDamage:(float)dmg
{
    if (self.life > 0)
    {
        self.life -= dmg;
    }
}



@end
