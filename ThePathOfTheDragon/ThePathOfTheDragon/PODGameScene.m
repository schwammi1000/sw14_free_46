//
//  PODMyScene.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 31.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODGameScene.h"

@implementation PODGameScene

PODCollisionHandling *collisionHandling;

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    if(self == nil)
        return nil;
    
    self.game = [PODGameNode createGame];
    [self.game setAnchorPoint:CGPointMake(0, 0)];
    self.game.position = CGPointMake(0, 0);
    
    [self addChild:self.game];
    
    [self.game.map setAnchorPoint:CGPointMake(0, 0)];
    [self.game.hero setAnchorPoint:CGPointMake(0, 0)];
    
    collisionHandling = [[PODCollisionHandling alloc] init];
    self.physicsWorld.contactDelegate = collisionHandling;
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    CGVector delta = CGVectorMake(location.x - self.game.hero.position.x - self.game.position.x, location.y - self.game.hero.position.y - self.game.position.y);
    
    if(fabs(delta.dx) >= fabs(delta.dy))
        delta = CGVectorMake(128 * delta.dx/fabs(delta.dx), 0);
    else
        delta = CGVectorMake(0, 128 * delta.dy/fabs(delta.dy));
    
    [self.game.hero moveHeroRelative:delta];
}

-(void)update:(CFTimeInterval)currentTime
{
    CGPoint newPosition = CGPointMake(-self.game.hero.position.x + 384, -self.game.hero.position.y + 512);
    self.game.position = newPosition;
}

-(void)didMoveToView:(SKView *)view
{
    
}

@end