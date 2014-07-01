//
//  Boid.m
//  BEHGame
//
//  Created by Jack Lor on 05/02/13.
//
//

#import "Boid.h"
#import "Globals.h"

@implementation Boid

@synthesize acc, vel;
@synthesize maxForce;
@synthesize boidList;

- (id)initWithPos:(Vector3D *)loc
{
    self = [super initWithPos:loc type:@"enemy" size:4 fileName:@"boid.png"];
    if (self)
    {
        int r = rand() % 29 + 20;
        self.life = 4.5f;
        self.maxSpeed = r / 10.f;
        //NSLog(@"mspeed %f ", maxSpeed);
        maxForce = 0.05f;
        vel = [[Vector3D alloc] initWithAxeX:0 axeY:0];
        acc = [[Vector3D alloc] initWithAxeX:0 axeY:0];
        self.scale = 0.9f;
    }
    
    return self;
}

#pragma - Boid reactions

- (void)seek:(Vector3D *)target
{
    [acc add:[self steerWithTarget:target slownDown:false]];
}

- (void) arrive:(Vector3D *)target
{    
    [acc add:[self steerWithTarget:target slownDown:true]];
}

- (Vector3D *)steerWithTarget:(Vector3D *) target  slownDown:(BOOL)slowdown
{
    
    Vector3D *steer;  // The steering vector
    
    Vector3D *desired = [[Vector3D alloc] initWithAxeX:target.x axeY:target.y];
    [desired sub:self.pos];
    
    float d = [desired magnitude]; // Distance from the target is the magnitude of the vector
    
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    
    if (d > 0)
    {
        // Normalize desired        
        [desired normalize];
        
        // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)        
        if ((slowdown) && (d < 100.0f))
            [desired mult:self.maxSpeed * (d / 100.0f)]; // This damping is somewhat arbitrary
        else
            [desired mult:self.maxSpeed];
        
        // Steering = Desired minus Velocity        
        steer = [[Vector3D alloc] initWithAxeX:desired.x axeY:desired.y];
        [steer sub:vel];        
        [steer limit:maxForce];  // Limit to maximum steering force        
    }
    else
    {       
        steer = [[Vector3D alloc] initWithAxeX:0 axeY:0];        
    }    
    return steer;    
}

// Method checks for nearby boids and steers away

- (Vector3D *)separate
{    
    float desiredseparation = 25.0f;
    
    Vector3D *sum = [[Vector3D alloc] initWithAxeX:0 axeY:0];
    
    int count = 0;
    
    // For every boid in the system, check if it's too close        
    for (Boid *other in boidList)
    {        
        float d = [self.pos distanceWithVector:other.pos];
        
        // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        
        if ((d > 0) && (d < desiredseparation))
        {
            // Calculate vector pointing away from neighbor
            Vector3D *diff = [[Vector3D alloc] initWithAxeX:self.pos.x axeY:self.pos.y];
            [diff sub:other.pos];
            
            [diff normalize];
            
            [diff div:d];        // Weight by distance
            
            [sum add:diff];
            
            count++;            // Keep track of how many
            
        }        
    }  
        
    // Average -- divide by how many    
    if (count > 0)
    {        
        [sum div:count];
    }
    
    return sum;    
}

- (Vector3D *)align
{    
    float neighbordist = 50.0f;
    
    Vector3D *sum = [[Vector3D alloc] initWithAxeX:0 axeY:0];
    
    int count = 0;
    
    for (Boid *other in boidList)
    {
        float d = [self.pos distanceWithVector:other.pos];
        
        if ((d > 0) && (d < neighbordist))
        {                        
            [sum add:other.vel];            
            count++;            
        }        
    }
    
    if (count > 0)
    {
        [sum div:count];
        [sum limit:maxForce];        
    }
    
    return sum;    
}

- (Vector3D *)cohesion
{    
    float neighbordist = 50.0f;
    
    Vector3D *sum = [[Vector3D alloc] initWithAxeX:0 axeY:0];   // Start with empty vector to accumulate all locations
    
    int count = 0;
    
    for (Boid *other in boidList)
    {        
        float d = [self.pos distanceWithVector:other.pos];
        
        if ((d > 0) && (d < neighbordist))
        {
            [sum add:other.pos];
            
            count++;            
        }        
    }
    
    if (count > 0)
    {        
        [sum div:count];        
        return [self steerWithTarget:sum slownDown:NO];  // Steer towards the location        
    }    
    return sum;    
}

- (void)flock
{
    if (!boidList)
        boidList = [[NSMutableArray alloc] init];
    
    Vector3D *sep = [self separate];   // Separation
    Vector3D *ali = [self align];      // Alignment
    Vector3D *coh = [self cohesion];   // Cohesion    
    
    // Arbitrarily weight these forces    
    [sep mult:2.0f];    
    [ali mult:1.0f];    
    [coh mult:1.0f];
    
    // Add the force vectors to acceleration    
    [acc add:sep];    
    [acc add:ali];
    [acc add:coh];
}

#pragma - update

- (void)baseMovement
{
    [vel add:acc];
    
    [vel limit:self.maxSpeed];
    [self.pos add:vel];
    
    [acc setZero];
    
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
    [self flock];
    
    //
    [self baseMovement];
    
    //
    [self borders];
    [self render];
    
    [super update];    
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
