//
//  SimpleButton.m
//  BEHGame
//
//  Created by Jack Lor on 05/02/13.
//
//

#import "SimpleButton.h"

@implementation SimpleButton

@synthesize selectors;

+(id)buttonWithFile:(NSString *)fileName radius:(float)radius selectors:(NSDictionary *)selects
{
    return [[self alloc] initWithFile:fileName radius:radius selectors:selects];
}

-(id)initWithFile:(NSString *)filename radius:(float)radius selectors:(NSDictionary *)selects
{
    if ((self = [super initWithFile:filename]))
    {
        _radius = radius;
        _isHeld = NO;
        selectors = selects;
        
        [self scheduleUpdate];
    }
    return self;
}

-(void)onEnterTransitionDidFinish
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:NO];
}

-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}


-(void)update:(ccTime)dt
{
    if (_isHeld)
    {
        [_delegate performSelector:NSSelectorFromString([selectors objectForKey:@"holding"]) withObject:self];
    }
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    float distanceSQ = ccpDistanceSQ(location, position_);
    if (distanceSQ <= _radius * _radius)
    {
        _isHeld = YES;
        self.scale = 1.7;
        self.opacity = 70;
        [_delegate performSelector:NSSelectorFromString([selectors objectForKey:@"started"]) withObject:self];
        return YES;
    }
    return NO;
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _isHeld = NO;
    self.scale = 2.0;
    self.opacity = 100;
    [_delegate performSelector:NSSelectorFromString([selectors objectForKey:@"ended"]) withObject:self];
}

@end

