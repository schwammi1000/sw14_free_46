//
//  PODCastleNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 31.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODCastleNode.h"

@implementation PODCastleNode

+(instancetype)castleWithSize:(CGSize)size Complexity:(NSNumber*)complexity
{
    PODCastleNode *castle = [[PODCastleNode alloc] init];
    
    if(castle == nil)
        return nil;
    
    castle.atlas = [SKTextureAtlas atlasNamed:@"Castle"];
    
    [castle createExampleCastle];
    
    return castle;
}

-(void)createExampleCastle
{
    SKSpriteNode *lu = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"TowerBottom"]];
    SKSpriteNode *l  = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"WallVertical"]];
    SKSpriteNode *lo = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"TowerTop"]];
    SKSpriteNode *o  = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"WallHorizontal"]];
    SKSpriteNode *ro = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"TowerTop"]];
    SKSpriteNode *r  = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"WallVertical"]];
    SKSpriteNode *ru = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"TowerBottom"]];
    
    [lu setAnchorPoint:CGPointMake(0, 0)];
    [l  setAnchorPoint:CGPointMake(0, 0)];
    [lo setAnchorPoint:CGPointMake(0, 0)];
    [o  setAnchorPoint:CGPointMake(0, 0)];
    [ro setAnchorPoint:CGPointMake(0, 0)];
    [r  setAnchorPoint:CGPointMake(0, 0)];
    [ru setAnchorPoint:CGPointMake(0, 0)];
    
    [l setPosition:CGPointMake(23, lu.size.height)];
    [lo setPosition:CGPointMake(0, lu.size.height + l.size.height)];
    [o setPosition:CGPointMake(lo.size.width, lu.size.height + l.size.height + 32)];
    [ro setPosition:CGPointMake(lo.size.width + o.size.width, lu.size.height + l.size.height)];
    [r setPosition:CGPointMake(lo.size.width + o.size.width + 23, lu.size.height)];
    [ru setPosition:CGPointMake(lo.size.width + o.size.width, 0)];
    
    [self addChild:lu];
    [self addChild:l];
    [self addChild:lo];
    [self addChild:o];
    [self addChild:ro];
    [self addChild:r];
    [self addChild:ru];
    
    
}

@end
