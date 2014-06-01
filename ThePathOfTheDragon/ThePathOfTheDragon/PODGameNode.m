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
    UIColor *color = [UIColor colorWithRed:255 green:0 blue:0 alpha:1];
    game.hero = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(32, 32)];
    game.hero.anchorPoint = CGPointMake(0, 0);
    game.hero.position = CGPointMake(384, 512);
    
    //Add River
    [game.map addRiver:[PODRiverNode createRiver:1280] At:CGPointMake(0, 0)];
    
    //Add Castle
    [game.map addCastle:[PODCastleNode createCastleWithSize:CGSizeMake(500, 500) NrOfTowers:4] At:CGPointMake(320, 64)];
    
    
    [game addChild:game.map];
    [game addChild:game.hero];
    
    return game;
}

-(void)moveHeroRelative:(CGVector)movement
{
    self.map.position = CGPointMake(self.map.position.x - movement.dx, self.map.position.y - movement.dy);
}

@end
