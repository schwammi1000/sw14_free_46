//
//  PODBackgroundNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODMapNode.h"

@implementation PODMapNode

+(instancetype)createMapWithSize:(CGSize)mapSize Tilesize:(CGSize)tileSize Texture:(NSString *)name
{
    PODMapNode *map = [[PODMapNode alloc] init];
    
    if(map == nil)
        return nil;
    
    //Initialzize category child nodes
    map.background = [[SKNode alloc] init];
    map.rivers = [[SKNode alloc] init];
    map.castles = [[SKNode alloc] init];
    
    //Add category child nodes
    [map addChild:map.background];
    [map addChild:map.rivers];
    [map addChild:map.castles];
    
    //Create map atlas
    map.atlas = [SKTextureAtlas atlasNamed:@"Background"];
    SKTexture *texture = [map.atlas textureNamed:name];
    
    //Create map
    for(int x = 0; x < mapSize.width; x++)
    {
        for(int y = 0; y < mapSize.height; y++)
        {
            SKSpriteNode *tile = [SKSpriteNode spriteNodeWithTexture:texture size:tileSize];
            [tile setAnchorPoint:CGPointMake(0.0, 0.0)];
            [tile setPosition:CGPointMake(x * tileSize.width, y * tileSize.height)];
            [map.background addChild:tile];
        }
    }
    
    //Configure map
    [map setAnchorPoint:CGPointMake(0, 0)];
    [map setPosition:CGPointMake(0, 0)];
    
    return map;
}

-(void)addCastle:(PODCastleNode *)castle At:(CGPoint)position
{
    castle.position = position;
    [self.castles addChild:castle];
}

-(void)addRiver:(PODRiverNode *)river At:(CGPoint)position
{
    river.position = position;
    [self.rivers addChild:river];
}

@end