//
//  PODCoinNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 11.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODCoinNode.h"
#import "PODCollisionHandling.h"

@implementation PODCoinNode

+(instancetype)createCoin
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Coin"];
    
    PODCoinNode *coinNode = [[PODCoinNode alloc] init];
    coinNode.anchorPoint = CGPointMake(0, 0);
    
    SKSpriteNode *coin = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"Coin"]];
    SKSpriteNode *shadow = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"Shadow"]];
    
    coin.position = CGPointMake(coin.position.x + 32, coin.position.y + 32);
    shadow.position = CGPointMake(shadow.position.x + 32, shadow.position.y + 32);
    
    SKAction *rotating = [SKAction repeatActionForever:[SKAction rotateByAngle:6.28 duration:3]];
    [coin runAction:rotating];
    coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:18];
    
    [coinNode addChild:shadow];
    [coinNode addChild:coin];
    
    coin.physicsBody.affectedByGravity = false;
    coin.physicsBody.dynamic = false;
    
    coin.physicsBody.categoryBitMask = COIN;
    
    return coinNode;
}

@end