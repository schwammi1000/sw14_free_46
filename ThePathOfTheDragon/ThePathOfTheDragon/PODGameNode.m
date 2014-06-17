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
    
    game.anchorPoint = CGPointMake(0, 0);
    game.position = CGPointMake(0, 0);
    
    game.map = [PODMapNode createMapWithSize:CGSizeMake(NR_TILES_X, NR_TILES_Y) Tilesize:CGSizeMake(TILE_WIDTH, TILE_HEIGHT) Texture:@"DesertXLarge"];
    
    game.hero = [PODHero createHeroWithNeededCoins:50];
    
    [game.map addRiver:[PODRiverNode createRiver:(1024*16)TileSize:32] At:CGPointMake(0, 0)];
    
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:3] At:CGPointMake(2000, 2000)];
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:2] At:CGPointMake(8000, 6000)];
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:1] At:CGPointMake(7000, 7000)];
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:1] At:CGPointMake(15000, 2000)];
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:4] At:CGPointMake(6000, 12000)];
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:1] At:CGPointMake(1000, 14000)];
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:3] At:CGPointMake(14000, 8000)];
    
    [game.map add:500 CoinsWithStartValue:0];

    [game addChild:game.map];
    [game addChild:game.hero];
    
    game.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, NR_TILES_X * TILE_WIDTH, NR_TILES_Y * TILE_HEIGHT)];

    return game;
}


@end
