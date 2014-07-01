//
//  Gack.h
//  BEHGame
//
//  Created by Jack Lor on 04/02/13.
//
//

#import "CCScene.h"
#import "Entity.h"

@interface Gack : Entity
{
    bool accelerating;
}

@property (nonatomic, strong) Vector3D *vel;
@property (nonatomic, strong) Vector3D *acc;
@property (nonatomic, strong) Vector3D *dec;

- (id)init;
- (void)update;

- (void)accelerateStart;
- (void)accelerateEnd;

- (void)getDamage:(float)dmg;

@end
