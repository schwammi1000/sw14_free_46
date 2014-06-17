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
UIColor *activeColor;
UIColor *inactiveColor;
Boolean active = false;

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    if(self == nil)
        return nil;
    
    [self initNewGame];
    
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    self.scoreLabel.fontColor = [UIColor whiteColor];
    self.scoreLabel.fontSize = 15.0;
    self.scoreLabel.position = CGPointMake(100, 10);
    self.scoreLabel.zPosition = 90;
    [self addChild:self.scoreLabel];
    
    activeColor = [UIColor blueColor];
    inactiveColor = [UIColor redColor];
    
    self.buttonRestart = [self fireButtonNodeWithName:@"restart"];
    [self addChild:self.buttonRestart];
    
    return self;
}

-(void)initNewGame
{
    self.game = [PODGameNode createGame];
    [self addChild:self.game];
    
    collisionHandling = [[PODCollisionHandling alloc] initWithHero:self.game.hero];
    self.physicsWorld.contactDelegate = collisionHandling;
    nr_coins = self.game.map.coins.children.count;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchlocation = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:touchlocation];
    
    if ([node.name isEqualToString:@"restart"] || [node.name isEqualToString:@"label"])
    {
        self.buttonRestart.color = activeColor;
        active = true;
        
        [self restartGame];
    }
    else
    {
        self.gamepad = [PODGamePadNode createGamePadAtPosition:touchlocation];
        [self addChild:self.gamepad];
        CGVector newMovingDirection = [self.gamepad calculateNewMovingDirectionWithTouch:touches];
        [self.gamepad setPositionWithTouch:touches];
    
        [self.game.hero moveHero:newMovingDirection];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!active)
    {
        CGVector newMovingDirection = [self.gamepad calculateNewMovingDirectionWithTouch:touches];
        [self.gamepad setPositionWithTouch:touches];
    
        [self.game.hero changeMovingDirection:newMovingDirection];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!active)
    {
        [self.game.hero stopHero];
        [self.gamepad removeFromParent];
    }
    
    self.buttonRestart.color = inactiveColor;
    active = false;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!active)
    {
        [self.game.hero stopHero];
        [self.gamepad removeFromParent];
    }
    
    self.buttonRestart.color = inactiveColor;
    active = false;
}

-(void)update:(CFTimeInterval)currentTime
{
    CGPoint newPosition = CGPointMake(-self.game.hero.position.x + 384, -self.game.hero.position.y + 512);
    self.game.position = newPosition;
    NSString *scoreBoard = [NSString stringWithFormat:@"Coins: %d/%d", self.game.hero.coins, self.game.hero.neededCoins];
    self.scoreLabel.text = scoreBoard;
}

-(void)didMoveToView:(SKView *)view
{
    
}

- (SKSpriteNode *)fireButtonNodeWithName:(NSString*)name
{
    SKSpriteNode *fireNode = [SKSpriteNode spriteNodeWithColor:inactiveColor size:CGSizeMake(400, 30)];
    fireNode.anchorPoint = CGPointMake(0.5, 1);
    fireNode.position = CGPointMake(384,1000);
    fireNode.name = name;
    fireNode.zPosition = 97;
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    label.fontColor = [UIColor whiteColor];
    label.fontSize = 20;
    label.position = CGPointMake(0, -22);
    label.text = @"Restart";
    label.zPosition = 98;
    label.name = @"label";
    [fireNode addChild:label];
    
    return fireNode;
}

-(void)restartGame
{
    [self.game removeFromParent];
    [self initNewGame];
}

@end