//
//  PODGameNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODGameNode.h"

@implementation PODGameNode

+(instancetype)createGame
{
    PODGameNode *game = [[super alloc] init];
    
    if(game == nil)
        return nil;
    
    //Create Map
    game.map = [PODMapNode createMapWithSize:CGSizeMake(16, 16) Tilesize:CGSizeMake(1024, 1024) Texture:@"DesertXLarge"];
    
    //Create Hero
    /*UIColor *color = [UIColor colorWithRed:255 green:0 blue:0 alpha:1];
    game.hero = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(32, 32)];
    game.hero.anchorPoint = CGPointMake(0, 0);
    game.hero.position = CGPointMake(384, 512);*/
    
    [game initalizeHero];
    
    SKTexture *temp = game.hero_walking_frames_down[0];
    game.hero = [SKSpriteNode spriteNodeWithTexture:temp size:CGSizeMake(32, 32)];
    game.hero.anchorPoint = CGPointMake(0, 0);
    game.hero.position = CGPointMake(384, 512);
    
    
    //Add River
    [game.map addRiver:[PODRiverNode createRiver:(1024*16)TileSize:32] At:CGPointMake(0, 0)];
    
    //Add Castles
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:1] At:CGPointMake(3200, 640)];
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:2] At:CGPointMake(3200, 1600)];
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:3] At:CGPointMake(3200, 4800)];
    
    //game.map.xScale = 0.25; game.map.yScale = 0.25;
    //game.map.position = CGPointMake(-3200, -4800);
    
    
    [game addChild:game.map];
    [game addChild:game.hero];
    
    return game;
}

-(void)moveHeroRelative:(CGVector)movement
{
    //self.map.position = CGPointMake(self.map.position.x - movement.dx, self.map.position.y - movement.dy);
    CGPoint point_to_move = CGPointMake(self.map.position.x - movement.dx, self.map.position.y - movement.dy);
    
    [self.map runAction:[SKAction moveTo:point_to_move duration:0.8f]];
    
    if(movement.dx > 0)
    {
        [self.hero runAction:[SKAction repeatAction:[SKAction animateWithTextures:self.hero_walking_frames_right timePerFrame:0.2f resize:NO restore:YES] count:1]];
    }
    else if(movement.dx < 0)
    {
       [self.hero runAction:[SKAction repeatAction:[SKAction animateWithTextures:self.hero_walking_frames_left timePerFrame:0.2f resize:NO restore:YES] count:1]];
    }
    else if(movement.dy > 0)
    {
        [self.hero runAction:[SKAction repeatAction:[SKAction animateWithTextures:self.hero_walking_frames_up timePerFrame:0.2f resize:NO restore:YES] count:1]];
    }
    else if (movement.dy < 0)
    {
        [self.hero runAction:[SKAction repeatAction:[SKAction animateWithTextures:self.hero_walking_frames_down timePerFrame:0.2f resize:NO restore:YES] count:1]];
    }
    
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

@end
