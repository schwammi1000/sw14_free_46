//
//  PODCastleNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 31.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODCastleNode.h"

@implementation PODCastleNode

+(instancetype)getPreassembledCastleWithNr:(int)number
{
    switch (number)
    {
        case 0: return [PODCastleNode createExampleCastle];
        case 1: return [PODCastleNode createCastleWithCode:@"u 2 r 2 d 2 l 2"];
        case 2: return [PODCastleNode createCastleWithCode:@"u 2 l 1 u 4 r 6 d 4 l 1 d 2 l 4"];
        case 3: return [PODCastleNode createCastleWithCode:@"u 10 r 1 d 1 r 1 d 1 r 1 d 1 r 2 u 6 l 2 u 2 r 6 d 2 l 2 d 6 r 2 u 1 r 1 u 1 r 1 u 1 r 1 d 10 l 8 d 3 l 5 u 3 l 7"];
        default: return nil;
    }
}

+(instancetype)createCastleWithCode:(NSString *)code
{
    PODCastleNode *castle = [[PODCastleNode alloc] init];
    
    if(castle == nil)
        return nil;
    
    castle.atlas = [SKTextureAtlas atlasNamed:@"Castle"];
    
    //CGPoint pStart = CGPointMake(0, 0);
    CGPoint pCurrent = CGPointMake(0, 0);
    CGPoint anchor = CGPointMake(0, 0);
    CGVector delta;
    
    NSArray *commands = [code componentsSeparatedByString:@" "];
    
    NSString *commandOld = nil;
    
    
    for(NSUInteger i = 0; i < [commands count]; i += 2)
    {
        NSString *command = [commands objectAtIndex:i];
        NSString *numberOfTiles;
        int count = 0;
        
        if([command compare:@"s"] != 0)
        {
            numberOfTiles = [commands objectAtIndex:i+1];
            count = [numberOfTiles intValue];
        }
        
        for(int c = 0; c < count; c++)
        {
            if([command compare:@"u"] == 0)
            {
                if(c == 0)
                {
                    SKSpriteNode *tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerBottom"]];
                    tower.anchorPoint = anchor;
                    tower.position = pCurrent;
                    delta = CGVectorMake(0, tower.size.height);
                    pCurrent = CGPointMake(pCurrent.x + delta.dx, pCurrent.y + delta.dy);
                    [castle addChild:tower];
                }
                
                SKSpriteNode *node  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallVerticalLong"]];
                node.anchorPoint = anchor;
                node.position = CGPointMake(pCurrent.x + 23, pCurrent.y);
                delta = CGVectorMake(0, node.size.height);
                pCurrent = CGPointMake(pCurrent.x + delta.dx, pCurrent.y + delta.dy);
                [castle addChild:node];
            }
            else if([command compare:@"d"] == 0)
            {
                if(c == 0)
                {
                    SKSpriteNode *tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerTop"]];
                    tower.anchorPoint = anchor;
                    tower.position = pCurrent;
                    [castle addChild:tower];
                }
                
                SKSpriteNode *node  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallVerticalLong"]];
                node.anchorPoint = anchor;
                
                if(c == 0)
                    pCurrent.y = pCurrent.y - node.size.height;
                
                node.position = CGPointMake(pCurrent.x + 23, pCurrent.y);
                
                if(c != count - 1)
                {
                    delta = CGVectorMake(0, node.size.height);
                    pCurrent = CGPointMake(pCurrent.x + delta.dx, pCurrent.y - delta.dy);
                }
                
                [castle addChild:node];
            }
            else if([command compare:@"r"] == 0)
            {
                if(c == 0)
                {
                    SKSpriteNode *tower;
                    
                    if(commandOld == nil)
                       tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"Tower"]];
                    else if ([commandOld compare:@"u"] == 0)
                        tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerTop"]];
                    else
                    {
                        tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerBottom"]];
                        pCurrent.y = pCurrent.y - tower.size.height;
                    }
                    
                    tower.anchorPoint = anchor;
                    tower.position = pCurrent;
                    delta = CGVectorMake(tower.size.width, 0);
                    pCurrent = CGPointMake(pCurrent.x + delta.dx, pCurrent.y + delta.dy);
                    [castle addChild:tower];
                }
                
                SKSpriteNode *node  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallHorizontal"]];
                node.anchorPoint = anchor;
                node.position = CGPointMake(pCurrent.x, pCurrent.y + 32);
                delta = CGVectorMake(node.size.width, 0);
                pCurrent = CGPointMake(pCurrent.x + delta.dx, pCurrent.y + delta.dy);
                [castle addChild:node];
                
            }
            else if([command compare:@"l"] == 0)
            {
                if(c == 0)
                {
                    SKSpriteNode *tower;
                    
                    if(commandOld == nil)
                        tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"Tower"]];
                    else if ([commandOld compare:@"u"] == 0)
                        tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerTop"]];
                    else
                    {
                        tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerBottom"]];
                        pCurrent.y = pCurrent.y - tower.size.height;
                    }
                    
                    tower.anchorPoint = anchor;
                    tower.position = pCurrent;
                    [castle addChild:tower];
                }
                
                SKSpriteNode *node  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallHorizontal"]];
                node.anchorPoint = anchor;
                
                if(c == 0)
                    pCurrent.x = pCurrent.x - node.size.width;
                
                node.position = CGPointMake(pCurrent.x, pCurrent.y + 32);
                
                if(c != count - 1)
                {
                    delta = CGVectorMake(node.size.width, 0);
                    pCurrent = CGPointMake(pCurrent.x - delta.dx, pCurrent.y + delta.dy);
                }
                [castle addChild:node];
            }
            else if([command compare:@"s"] == 0)
            {
            
            }
        }
        
        commandOld = command;
    }
    
    //castle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1024, 1024)];

    return castle;
}

+(instancetype)createExampleCastle
{
    PODCastleNode *castle = [[PODCastleNode alloc] init];
    
    if(castle == nil)
        return nil;
    
    castle.atlas = [SKTextureAtlas atlasNamed:@"Castle"];
    
    SKSpriteNode *lu = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerBottom"]];
    SKSpriteNode *l  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallVerticalLong"]];
    SKSpriteNode *lo = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerTop"]];
    SKSpriteNode *o  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallHorizontal"]];
    SKSpriteNode *ro = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerTop"]];
    SKSpriteNode *r  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallVerticalLong"]];
    SKSpriteNode *ru = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerBottom"]];
    
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
    
    [castle addChild:lu];
    [castle addChild:l];
    [castle addChild:lo];
    [castle addChild:o];
    [castle addChild:ro];
    [castle addChild:r];
    [castle addChild:ru];
    
    return castle;
}

-(SKSpriteNode*)createCastleNodeWithTexture: (NSString*)texture AtPosition: (CGPoint)position AndAtlas: (SKTextureAtlas*)atlas
{
    SKSpriteNode *tower  = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:texture]];
    tower.anchorPoint = CGPointMake(0, 0);
    tower.position = position;
    
    return tower;

}


@end
