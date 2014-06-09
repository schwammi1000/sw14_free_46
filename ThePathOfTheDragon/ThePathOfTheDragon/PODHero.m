//
//  PODHero.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 09.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODHero.h"

@implementation PODHero

+(instancetype)createHero
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"spriteHero"];
    PODHero * hero = [[PODHero alloc] initWithTexture:[atlas textureNamed:@"animation_1"] color:nil size:CGSizeMake(32, 32)];
    
    if(hero == nil)
        return nil;
    
    [hero initalizeWholeAnimation];
    hero.anchorPoint = CGPointMake(0, 0);
    hero.position = CGPointMake(992, 992);
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size center:CGPointMake(hero.size.width/2, hero.size.height/2)];
    hero.physicsBody.affectedByGravity = false;
    
    hero.rangeOfOneAnimation = 32;
    hero.nrOfAnimationTextures = 5;
    hero.runningDurationOfOneAnimation = 0.5;
    
    
    return hero;
}

-(void)initalizeWholeAnimation
{
    self.hero_walking_frames_down  = [self initializeAnimationFromIndex:1  To:5];
    self.hero_walking_frames_up    = [self initializeAnimationFromIndex:11 To:15];
    self.hero_walking_frames_left  = [self initializeAnimationFromIndex:6  To:10];
    self.hero_walking_frames_right = [self initializeAnimationFromIndex:16 To:20];
}

-(void)moveHeroRelative:(CGVector)movement
{
    if(movement.dx > 0)
        [self animateHeroX:self.rangeOfOneAnimation Y:0 AnimationSet:self.hero_walking_frames_right];
    
    else if(movement.dx < 0)
        [self animateHeroX:-self.rangeOfOneAnimation Y:0 AnimationSet:self.hero_walking_frames_left];
    
    else if(movement.dy > 0)
        [self animateHeroX:0 Y:self.rangeOfOneAnimation AnimationSet:self.hero_walking_frames_up];
    
    else if (movement.dy < 0)
        [self animateHeroX:0 Y:-self.rangeOfOneAnimation AnimationSet:self.hero_walking_frames_down];
}

-(void)animateHeroX:(CGFloat)x Y:(CGFloat)y AnimationSet:(NSArray*)walking
{
    SKAction *animation = [SKAction repeatAction:[SKAction animateWithTextures:walking timePerFrame:self.runningDurationOfOneAnimation/self.nrOfAnimationTextures resize:NO restore:YES] count:10];
    SKAction *movement = [SKAction repeatAction:[SKAction moveByX:x y:y duration:self.runningDurationOfOneAnimation] count: 10];
    
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

@end
