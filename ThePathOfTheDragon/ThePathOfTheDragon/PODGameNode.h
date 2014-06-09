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

@interface PODGameNode : SKSpriteNode

@property PODMapNode *map;
@property PODHero *hero;

+(instancetype)createGame;

@end
