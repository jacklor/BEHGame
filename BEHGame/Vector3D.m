//
//  Vector3D.m
//  BEHGame
//
//  Created by Jack Lor on 28/01/13.
//
//

#import "Vector3D.h"

@implementation Vector3D

@synthesize x, y, z;

#pragma mark - Init

-(id)init
{
    self = [super init];
    if (self)
    {
        x = 0;
        y = 0;
        z = 0;
    }
    return self;
}

-(id)initWithAxeX:(float)axeX axeY:(float)axeY
{
    self = [super init];
    if (self)
    {
        x = axeX;
        y = axeY;
        z = 0;
    }
    return self;
}



#pragma mark - Operations

- (void)setZero
{
    x = 0;
    y = 0;
    z = 0;
}

- (void)add:(Vector3D *)v
{    
    x += v.x;    
    y += v.y;    
    z += v.z;    
}

- (void)sub:(Vector3D *)v
{    
    x -= v.x;    
    y -= v.y;    
    z -= v.z;    
}

- (void)mult:(float)n
{    
    x *= n;    
    y *= n;    
    z *= n;    
}

- (void)div:(float)n
{    
    x /= n;    
    y /= n;    
    z /= n;    
}


#pragma mark - Calculations

- (float)magnitude
{    
    return (float) sqrt(x*x + y*y + z*z);    
}

- (void)normalize
{    
    float m = [self magnitude];
    
    if (m > 0)
    {        
        [self div:m];
    }    
}

- (void)limit:(float)max
{    
    if ([self magnitude] > max)
    {        
        [self normalize];        
        [self mult:max];        
    }    
}

- (float)heading2D
{    
    float angle = (float) atan2(y, x);
    
    return -1 * angle;
}

- (float)distanceWithVector:(Vector3D *)v2
{
    
    float dx = self.x - v2.x;
    
    float dy = self.y - v2.y;
    
    float dz = self.z - v2.z;
    
    return (float) sqrt(dx*dx + dy*dy + dz*dz);    
}

@end
