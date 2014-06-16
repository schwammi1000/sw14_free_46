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

int nr_coins;

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    if(self == nil)
        return nil;
    
    self.game = [PODGameNode createGame];
    [self.game setAnchorPoint:CGPointMake(0, 0)];
    self.game.position = CGPointMake(0, 0);
    
    [self addChild:self.game];
    
    collisionHandling = [[PODCollisionHandling alloc] initWithHero:self.game.hero];
    self.physicsWorld.contactDelegate = collisionHandling;
    
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    self.scoreLabel.fontColor = [UIColor whiteColor];
    self.scoreLabel.fontSize = 15.0;
    self.scoreLabel.position = CGPointMake(100, 10);
    
    [self addChild:self.scoreLabel];
    
    nr_coins = self.game.map.coins.children.count;
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchlocation = [touch locationInNode:self];
    
    self.gamepad = [PODGamePadNode createGamePadAtPosition:touchlocation];
    [self addChild:self.gamepad];
    CGVector newMovingDirection = [self.gamepad calculateNewMovingDirectionWithTouch:touches];
    [self.gamepad setPositionWithTouch:touches];
    
    [self.game.hero moveHero:newMovingDirection];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGVector newMovingDirection = [self.gamepad calculateNewMovingDirectionWithTouch:touches];
    [self.gamepad setPositionWithTouch:touches];
    
    [self.game.hero changeMovingDirection:newMovingDirection];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.game.hero stopHero];
    [self.gamepad removeFromParent];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.game.hero stopHero];
    [self.gamepad removeFromParent];
}

-(void)update:(CFTimeInterval)currentTime
{
    CGPoint newPosition = CGPointMake(-self.game.hero.position.x + 384, -self.game.hero.position.y + 512);
    self.game.position = newPosition;
    NSString *scoreBoard = [NSString stringWithFormat:@"Coins: %d/%d", self.game.hero.coins, nr_coins];
    self.scoreLabel.text = scoreBoard;
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