//
//  PODBackgroundNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PODCastleNode.h"
#import "PODRiverNode.h"

@interface PODMapNode : SKNode

@property SKNode *background;
@property SKNode *castles;
@property SKNode *rivers;

@property SKTextureAtlas *atlas;

+(instancetype)createMapWithSize:(CGSize)mapSize Tilesize:(CGSize)tileSize Texture:(NSString *)name;

-(void)addCastle:(PODCastleNode *)castle At:(CGPoint)position;

-(void)addRiver:(PODRiverNode *)river At:(CGPoint)position;

@end
