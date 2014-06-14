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
    
    //Create Gamepad
    self.gamepad = [PODGamePadNode createGamePad];
    [self addChild:self.gamepad];
    
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //CGVector newMovingDirection = [self calculateNewMovingDirectionWithTouch:touches];
    CGVector newMovingDirection = [self.gamepad calculateNewMovingDirectionWithTouch:touches];
    [self.gamepad setPositionWithTouch:touches];
    
    [self.game.hero moveHero:newMovingDirection];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //CGVector newMovingDirection = [self calculateNewMovingDirectionWithTouch:touches];
    CGVector newMovingDirection = [self.gamepad calculateNewMovingDirectionWithTouch:touches];
    [self.gamepad setPositionWithTouch:touches];
    
    [self.game.hero changeMovingDirection:newMovingDirection];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.game.hero stopHero];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.game.hero stopHero];
}

-(void)update:(CFTimeInterval)currentTime
{
    CGPoint newPosition = CGPointMake(-self.game.hero.position.x + 384, -self.game.hero.position.y + 512);
    self.game.position = newPosition;
}

-(void)didMoveToView:(SKView *)view
{
    
}

-(CGVector)calculateNewMovingDirectionWithTouch:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchlocation = [touch locationInNode:self];
    CGVector newMovingDirection = CGVectorMake(touchlocation.x - self.game.hero.position.x - self.game.position.x, touchlocation.y - self.game.hero.position.y - self.game.position.y);
    
    if(fabs(newMovingDirection.dx) >= fabs(newMovingDirection.dy))
        newMovingDirection = CGVectorMake(newMovingDirection.dx/fabs(newMovingDirection.dx), 0);
    else
        newMovingDirection = CGVectorMake(0, newMovingDirection.dy/fabs(newMovingDirection.dy));
    
    return newMovingDirection;
}

@end