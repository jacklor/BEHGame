//
//  Damaging.h
//  BEHGame
//
//  Created by Jack Lor on 06/02/13.
//
//

#import "Entity.h"

@interface Damaging : Entity

@property (nonatomic, assign) id target;

@property float damage;

- (id)initWithPos:(Vector3D *)loc
              size:(float)s
          fileName:(NSString *)file
            damage:(float)dmg
            target:(id)tar;

@end
