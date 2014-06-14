//
//  PODGameNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PODMapNode.h"
#import "PODCastleNode.h"
#import "PODRiverNode.h"
#import "PODHero.h"

#define TILE_WIDTH 1024
#define TILE_HEIGHT 1024
#define NR_TILES_X 16
#define NR_TILES_Y 16

@interface PODGameNode : SKSpriteNode

@property PODMapNode *map;
@property PODHero *hero;

+(instancetype)createGame;
-(BOOL)isBuildable:(SKSpriteNode*) node;

@end
