//
//  Entity.h
//  BEHGame
//
//  Created by Jack Lor on 28/01/13.
//
//

#import <Foundation/Foundation.h>
#import "Vector3D.h"
#import "cocos2d.h"

@interface Entity : CCSprite

@property (nonatomic, strong) Vector3D *pos;
@property float size;
@property float life;
@property float maxSpeed;
@property (nonatomic, strong) NSString *type;

- (id)initWithPos:(Vector3D *)loc type:(NSString *)t size:(float)s fileName:(NSString *)str;

- (void)update;

@end
