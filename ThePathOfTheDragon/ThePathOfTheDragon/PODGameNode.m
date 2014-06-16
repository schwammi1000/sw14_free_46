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
    
    game.map = [PODMapNode createMapWithSize:CGSizeMake(NR_TILES_X, NR_TILES_Y) Tilesize:CGSizeMake(TILE_WIDTH, TILE_HEIGHT) Texture:@"DesertXLarge"];
    
    game.hero = [PODHero createHero];
    
    [game.map addRiver:[PODRiverNode createRiver:(1024*16)TileSize:32] At:CGPointMake(0, 0)];
    
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:3] At:CGPointMake(2048, 2048)];
    
    [game.map add:500 CoinsWithStartValue:0];

    [game addChild:game.map];
    [game addChild:game.hero];
    
    game.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 16*1024, 16*1024)];
    
    //[game.map setScale:0.1];
    
    return game;
}


@end
