//
//  Vector3D.h
//  BEHGame
//
//  Created by Jack Lor on 28/01/13.
//
//

#import <Foundation/Foundation.h>

@interface Vector3D : NSObject

@property float x, y, z;

- (id)init;
- (id)initWithAxeX:(float)axeX axeY:(float)axeY;

- (void)add:(Vector3D *)v;
- (void)sub:(Vector3D *)v;
- (void)mult:(float)n;
- (void)div:(float)n;

- (float)magnitude;
- (void)normalize;
- (void)limit:(float)max;
- (float)heading2D;

- (float) distanceWithVector:(Vector3D *)v2;

- (void)setZero;

@end
