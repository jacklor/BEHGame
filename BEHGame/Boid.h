//
//  Boid.h
//  BEHGame
//
//  Created by Jack Lor on 05/02/13.
//
//

#import "Entity.h"

@interface Boid : Entity

@property (nonatomic, assign) NSMutableArray *boidList;

@property float maxForce;
@property (nonatomic, strong) Vector3D *vel;
@property (nonatomic, strong) Vector3D *acc;

- (id)initWithPos:(Vector3D *)loc;


- (void)seek:(Vector3D *)target;
- (void)arrive:(Vector3D *)target;

- (void)getDamage:(float)dmg;

@end
