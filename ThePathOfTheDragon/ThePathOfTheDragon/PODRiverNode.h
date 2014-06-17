//
//  PODRiverNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PODRiverNode : SKSpriteNode

@property SKTextureAtlas *atlas;
@property CGMutablePathRef path_left;
@property CGMutablePathRef path_right;
@property SKShapeNode *shape_right;
@property SKShapeNode *shape_left;

+(instancetype)createRiver: (int)start_point TileSize: (int)tile_size;

@end
