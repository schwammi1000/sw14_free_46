//
//  PODGameNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODGameNode.h"

@implementation PODGameNode

//char meinArray[NR_TILES_Y * TILE_HEIGHT / 32][NR_TILES_X * TILE_WIDTH / 32] = {{0}};

+(instancetype)createGame
{
    PODGameNode *game = [[super alloc] init];
    
    if(game == nil)
        return nil;
    
    //Create Map
    game.map = [PODMapNode createMapWithSize:CGSizeMake(NR_TILES_X, NR_TILES_Y) Tilesize:CGSizeMake(TILE_WIDTH, TILE_HEIGHT) Texture:@"DesertXLarge"];
    
    //Create Hero
    game.hero = [PODHero createHero];
        
    //Add River
    [game.map addRiver:[PODRiverNode createRiver:(1024*16)TileSize:32] At:CGPointMake(0, 0)];
    
    //Add Castles
    [game.map addCastle:[PODCastleNode getPreassembledCastleWithNr:3] At:CGPointMake(1024, 1024)];
    
    //Add Coins
    [game.map add:25 CoinsWithStartValue:0];

    //Add everything to the map
    [game addChild:game.map];
    [game addChild:game.hero];
    
    //Create worlds boundings
    game.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 16*1024, 16*1024)];
    
    //[game.map setScale:0.1];
    
    return game;
}

-(BOOL)isBuildable:(SKSpriteNode*) node
{
    if(rand() / RAND_MAX < 0.5)
        return true;
    else
        return false;
}

@end
