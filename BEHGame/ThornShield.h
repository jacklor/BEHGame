//
//  ThornShield.h
//  BEHGame
//
//  Created by Jack Lor on 06/02/13.
//
//

#import "Damaging.h"

@interface ThornShield : Damaging
{
    float shieldRotation;
}

- (id)initWithPos:(Vector3D *)loc target:(id)tar;

@end
