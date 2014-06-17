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
    srand(time(NULL));
    PODMapNode *map = [[PODMapNode alloc] init];
    map.textureName = name;
    
    if(map == nil)
        return nil;
    
    map.background = [[SKNode alloc] init];
    map.rivers = [[SKNode alloc] init];
    map.castles = [[SKNode alloc] init];
    map.coins = [[SKNode alloc] init];
    
    [map addChild:map.background];
    [map addChild:map.rivers];
    [map addChild:map.castles];
    [map addChild:map.coins];
    
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
    
    [map setAnchorPoint:CGPointMake(0, 0)];
    
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

-(void)addCoin:(PODCoinNode *)coin At:(CGPoint)position
{
    coin.position = position;
    [self.coins addChild:coin];
}

-(void)add:(int)numberCoins CoinsWithStartValue:(int)start
{
    int countCoins = start;
    
    int nrTilesPerField = (1024 / 64) * (1024 / 64);
    int numberTiles = (int)[[self.background children] count] * nrTilesPerField;
    
    float possibility = (float)numberCoins/numberTiles * 100;
    
    for(int x = 0; x < 1024*16; x += 64)
    {
        for(int y = 0; y < 1024*16; y += 64)
        {
            if([self possibilityOf:possibility])
            {
                countCoins++;
                
                [self addCoin:[PODCoinNode createCoin] At:CGPointMake(x, y)];
                
                if(countCoins >= numberCoins)
                    return;
            }
        }
    }
    
    if(countCoins < numberCoins)
        [self add:numberCoins CoinsWithStartValue:countCoins];
}

-(BOOL)possibilityOf:(float)percent
{
    float random = (float)rand() / RAND_MAX;
    
    percent /= 100;
    
    if(random < percent)
        return true;
    else
        return false;
}

@end