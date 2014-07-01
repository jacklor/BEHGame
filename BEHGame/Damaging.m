//
//  Damaging.m
//  BEHGame
//
//  Created by Jack Lor on 06/02/13.
//
//

#import "Damaging.h"
#import "Boid.h"
#import "Globals.h"

@implementation Damaging

@synthesize damage;
@synthesize target;

- (id)initWithPos:(Vector3D *)loc
              size:(float)s
          fileName:(NSString *)file
            damage:(float)dmg
            target:(id)tar

{
    self = [super initWithPos:loc type:@"damagingFromPlayer" size:s fileName:file];
    if (self)
    {
        NSNumber *zOrder = [[[Globals getGlobals] zOrderList] objectForKey:@"damaging"];
        self.zOrder =  zOrder.intValue;
        self.damage = dmg;
        self.maxSpeed = 0;
        self.scale = 1.f;
        self.target = tar;
    }    
    return self;
}

- (void)collision
{
    if ([self.type isEqualToString:@"damagingFromPlayer"])
    {
        NSMutableArray *boidList = (NSMutableArray *)self.target;
        for (Boid *boid in boidList)
        {            
            float d = [self.pos distanceWithVector:boid.pos];
            if (d >= 0 && (d <= self.size || d <= boid.size))
            {
                [boid getDamage:damage];
            }
        }
    }
}

- (void)update
{
    //
    [self collision];
    
    [super update];
}

@end
