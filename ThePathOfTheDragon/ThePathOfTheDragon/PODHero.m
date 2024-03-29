//
//  PODHero.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 09.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODHero.h"
#import "PODCollisionHandling.h"

@implementation PODHero

+(instancetype)createHeroWithNeededCoins:(int)possibleCoins
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"spriteHero"];
    PODHero *hero = [[PODHero alloc] initWithTexture:[atlas textureNamed:@"animation_1"] color:nil size:CGSizeMake(32, 32)];
    
    if(hero == nil)
        return nil;
    
    [hero initalizeWholeAnimation];
    hero.anchorPoint = CGPointMake(0, 0);
    hero.position = CGPointMake(1024, 992);
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size center:CGPointMake(hero.size.width/2, hero.size.height/2)];
    hero.physicsBody.affectedByGravity = false;
    hero.physicsBody.allowsRotation = false;
    hero.physicsBody.categoryBitMask = SPRITE;
    hero.physicsBody.collisionBitMask = COIN;
    hero.physicsBody.contactTestBitMask = COIN;
    
    hero.rangeOfOneAnimation = 48;
    hero.nrOfAnimationTextures = 5;
    hero.runningDurationOfOneAnimation = 0.8;
    hero.actualMovingDirection = CGVectorMake(0, 0);
    hero.coins = 0;
    
    [hero setSpeed:70];
    
    hero.neededCoins = possibleCoins;
    
    return hero;
}

-(void)initalizeWholeAnimation
{
    self.hero_walking_frames_down  = [self initializeAnimationFromIndex:1  To:5];
    self.hero_walking_frames_up    = [self initializeAnimationFromIndex:11 To:15];
    self.hero_walking_frames_left  = [self initializeAnimationFromIndex:6  To:10];
    self.hero_walking_frames_right = [self initializeAnimationFromIndex:16 To:20];
}

-(void)moveHero:(CGVector)newMovingDirection
{
    if(newMovingDirection.dx > 0)
        [self animateHeroX:self.rangeOfOneAnimation Y:0 AnimationSet:self.hero_walking_frames_right];
    
    else if(newMovingDirection.dx < 0)
        [self animateHeroX:-self.rangeOfOneAnimation Y:0 AnimationSet:self.hero_walking_frames_left];
    
    else if(newMovingDirection.dy > 0)
        [self animateHeroX:0 Y:self.rangeOfOneAnimation AnimationSet:self.hero_walking_frames_up];
    
    else if (newMovingDirection.dy < 0)
        [self animateHeroX:0 Y:-self.rangeOfOneAnimation AnimationSet:self.hero_walking_frames_down];
    
    self.actualMovingDirection = newMovingDirection;
}

-(void)changeMovingDirection:(CGVector)newMovingDirection
{
    if(newMovingDirection.dx == self.actualMovingDirection.dx && newMovingDirection.dy == self.actualMovingDirection.dy)
        return;
    
    [self stopHero];
    [self moveHero:newMovingDirection];
    
}

-(void)stopHero
{
    [self removeAllActions];
}

-(void)animateHeroX:(CGFloat)x Y:(CGFloat)y AnimationSet:(NSArray*)walking
{
    SKAction *animation = [SKAction repeatActionForever:[SKAction animateWithTextures:walking timePerFrame:self.runningDurationOfOneAnimation/self.nrOfAnimationTextures resize:NO restore:YES]];
    SKAction *movement = [SKAction repeatActionForever:[SKAction moveByX:x y:y duration:self.runningDurationOfOneAnimation]];
    
    if(![self hasActions])
    {
        [self runAction:animation];
        [self runAction:movement];
    }
    
    self.texture = walking[0];
}

-(NSArray*)initializeAnimationFromIndex:(int)from To:(int)to
{
    NSMutableArray *walkingFrame = [NSMutableArray array];
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"spriteHero"];
    
    for (int i = from; i <= to; i++)
    {
        NSString *animation_name = [NSString stringWithFormat:@"animation_%d", i];
        SKTexture *obj = [atlas textureNamed:animation_name];
        [walkingFrame addObject:obj];
    }
    
    return walkingFrame;
}

- (void)setSpeed:(int)newSpeed
{
    self.attributeSpeed = newSpeed;
    
    if(newSpeed > MAX_SPEED)
        self.attributeSpeed = MAX_SPEED;
    else if(newSpeed < MIN_SPEED)
        self.attributeSpeed = MIN_SPEED;
    
    self.runningDurationOfOneAnimation = -0.8 * self.attributeSpeed / 90 + 9.8 / 9;
}

-(void)foundCoin
{
    self.coins++;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CoinRain" ofType:@"sks"];
    SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    spark.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [self addChild:spark];
    
    if(self.coins >= self.neededCoins)
    {
        path = [[NSBundle mainBundle] pathForResource:@"Finished" ofType:@"sks"];
        SKEmitterNode *finished = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        finished.position = CGPointMake(self.size.width / 2, self.size.height * 2);
        [self addChild:finished];
        self.physicsBody.dynamic = NO;
    }
    
}

@end
