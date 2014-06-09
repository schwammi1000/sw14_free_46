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
    
    [hero initalizeHero];
    hero.anchorPoint = CGPointMake(0, 0);
    hero.position = CGPointMake(128, 128);
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size center:CGPointMake(hero.size.width/2, hero.size.height/2)];
    hero.physicsBody.affectedByGravity = false;
    hero.physicsBody.categoryBitMask = SPRITE;
    hero.physicsBody.collisionBitMask = CASTLE;
    hero.physicsBody.contactTestBitMask = SPRITE | CASTLE;
    
    hero.rangeOfOneClick = 320;
    
    return hero;
}

-(void)initalizeHero
{
    NSMutableArray *walking_frame_down = [NSMutableArray array];
    NSMutableArray *walking_frame_up = [NSMutableArray array];
    NSMutableArray *walking_frame_left = [NSMutableArray array];
    NSMutableArray *walking_frame_right = [NSMutableArray array];
    
    
    SKTextureAtlas *hero_walking_atlas = [SKTextureAtlas atlasNamed:@"spriteHero"];
    
    //Add animations for down- movement
    for (int i = 1; i <= 5; i++)
    {
        NSString *animation_name = [NSString stringWithFormat:@"animation_%d", i];
        SKTexture *obj = [hero_walking_atlas textureNamed:animation_name];
        [walking_frame_down addObject:obj];
    }
    self.hero_walking_frames_down = walking_frame_down;
    
    
    //Add animations for up- movement
    for (int i = 11; i <= 15; i++)
    {
        NSString *animation_name = [NSString stringWithFormat:@"animation_%d", i];
        SKTexture *obj = [hero_walking_atlas textureNamed:animation_name];
        [walking_frame_up addObject:obj];
    }
    self.hero_walking_frames_up = walking_frame_up;
    
    
    //Add animations for left- movement
    for (int i = 6; i <= 10; i++)
    {
        NSString *animation_name = [NSString stringWithFormat:@"animation_%d", i];
        SKTexture *obj = [hero_walking_atlas textureNamed:animation_name];
        [walking_frame_left addObject:obj];
    }
    self.hero_walking_frames_left = walking_frame_left;
    
    
    //Add animations for right- movement
    for (int i = 16; i <= 20; i++)
    {
        NSString *animation_name = [NSString stringWithFormat:@"animation_%d", i];
        SKTexture *obj = [hero_walking_atlas textureNamed:animation_name];
        [walking_frame_right addObject:obj];
    }
    self.hero_walking_frames_right = walking_frame_right;
}

-(void)moveHeroRelative:(CGVector)movement
{
    if(movement.dx > 0)
    {
        SKAction *animation = [SKAction repeatAction:[SKAction animateWithTextures:self.hero_walking_frames_right timePerFrame:0.04f resize:NO restore:YES] count:1];
        SKAction *movement = [SKAction moveByX:self.rangeOfOneClick y:0 duration:0.2];
        
        if(![self hasActions])
        {
            [self runAction:animation];
            [self runAction:movement];
        }
    }
    else if(movement.dx < 0)
    {
        SKAction *animation = [SKAction repeatAction:[SKAction animateWithTextures:self.hero_walking_frames_left timePerFrame:0.04f resize:NO restore:YES] count:1];
        SKAction *movement = [SKAction moveByX:-self.rangeOfOneClick y:0 duration:0.2];
        
        if(![self hasActions])
        {
            [self runAction:animation];
            [self runAction:movement];
        }
    }
    else if(movement.dy > 0)
    {
        SKAction *animation = [SKAction repeatAction:[SKAction animateWithTextures:self.hero_walking_frames_up timePerFrame:0.04f resize:NO restore:YES] count:1];
        SKAction *movement = [SKAction moveByX:0 y:self.rangeOfOneClick duration:0.2];
        
        if(![self hasActions])
        {
            [self runAction:animation];
            [self runAction:movement];
        }
    }
    else if (movement.dy < 0)
    {
        SKAction *animation = [SKAction repeatAction:[SKAction animateWithTextures:self.hero_walking_frames_down timePerFrame:0.04f resize:NO restore:YES] count:1];
        SKAction *movement = [SKAction moveByX:0 y:-self.rangeOfOneClick duration:0.2];
        
        if(![self hasActions])
        {
            [self runAction:animation];
            [self runAction:movement];
        }
    }
    
}

@end
