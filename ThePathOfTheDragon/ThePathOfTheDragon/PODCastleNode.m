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
        case 1: return [PODCastleNode createCastleWithCode:@"u 2 r 2 d 2 l 2"];
        case 2: return [PODCastleNode createCastleWithCode:@"u 2 l 1 u 4 r 6 d 4 l 1 d 2 l 4"];
        case 3: return [PODCastleNode createCastleWithCode:@"u 10 r 1 d 1 r 1 d 1 r 1 d 1 r 2 u 6 l 2 u 2 r 6 d 2 l 2 d 6 r 2 u 1 r 1 u 1 r 1 u 1 r 1 d 10 l 8 d 3 l 5 u 3 l 7"];
        default: return nil;
    }
}

+(instancetype)createCastleWithCode:(NSString *)code
{
    //Create parent node
    PODCastleNode *castle = [[PODCastleNode alloc] init];
    
    if(castle == nil)
        return nil;
    
    //Create atlas
    castle.atlas = [SKTextureAtlas atlasNamed:@"Castle"];
    
    castle.nrColor = 1;
    
    
    castle.pCurrent = CGPointMake(0, 0);
    CGVector delta;
    
    NSArray *commands = [code componentsSeparatedByString:@" "];
    
    NSString *commandOld = nil;
    
    
    for(NSUInteger i = 0; i < [commands count]; i += 2)
    {
        NSString *command = [commands objectAtIndex:i];
        int nrTilesToDraw = 0;
        
        if([command compare:@"s"] != 0)
            nrTilesToDraw = [[commands objectAtIndex:i+1] intValue];
        
        for(int c = 0; c < nrTilesToDraw; c++)
        {
            if([command compare:@"u"] == 0)
            {
                if(c == 0)
                {
                    SKSpriteNode *tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerBottom"]];
                    tower.position = castle.pCurrent;
                    delta = CGVectorMake(0, tower.size.height);
                    castle.pCurrent = CGPointMake(castle.pCurrent.x + delta.dx, castle.pCurrent.y + delta.dy);
                    [castle addPart:tower];
                }
                
                SKSpriteNode *node  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallVerticalLong"]];
                node.position = CGPointMake(castle.pCurrent.x + 23, castle.pCurrent.y);
                delta = CGVectorMake(0, node.size.height);
                castle.pCurrent = CGPointMake(castle.pCurrent.x + delta.dx, castle.pCurrent.y + delta.dy);
                [castle addPart:node];
            }
            else if([command compare:@"d"] == 0)
            {
                if(c == 0)
                {
                    SKSpriteNode *tower  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"TowerTop"]];
                    tower.position = castle.pCurrent;
                    [castle addPart:tower];
                }
                
                SKSpriteNode *node  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallVerticalLong"]];
                
                if(c == 0)
                    castle.pCurrent = CGPointMake(castle.pCurrent.x, castle.pCurrent.y - node.size.height);
                
                node.position = CGPointMake(castle.pCurrent.x + 23, castle.pCurrent.y);
                
                if(c != nrTilesToDraw - 1)
                {
                    delta = CGVectorMake(0, node.size.height);
                    castle.pCurrent = CGPointMake(castle.pCurrent.x + delta.dx, castle.pCurrent.y - delta.dy);
                }
                
                [castle addPart:node];
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
                        castle.pCurrent = CGPointMake(castle.pCurrent.x, castle.pCurrent.y - tower.size.height);
                    }
                    
                    tower.position = castle.pCurrent;
                    delta = CGVectorMake(tower.size.width, 0);
                    castle.pCurrent = CGPointMake(castle.pCurrent.x + delta.dx, castle.pCurrent.y + delta.dy);
                    [castle addPart:tower];
                }
                
                SKSpriteNode *node  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallHorizontal"]];
                node.position = CGPointMake(castle.pCurrent.x, castle.pCurrent.y + 32);
                delta = CGVectorMake(node.size.width, 0);
                castle.pCurrent = CGPointMake(castle.pCurrent.x + delta.dx, castle.pCurrent.y + delta.dy);
                [castle addPart:node];
                
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
                        castle.pCurrent = CGPointMake(castle.pCurrent.x, castle.pCurrent.y - tower.size.height);
                    }
                    
                    tower.position = castle.pCurrent;
                    [castle addPart:tower];
                }
                
                SKSpriteNode *node  = [SKSpriteNode spriteNodeWithTexture:[castle.atlas textureNamed:@"WallHorizontal"]];
                
                if(c == 0)
                    castle.pCurrent = CGPointMake(castle.pCurrent.x - node.size.width, castle.pCurrent.y);
                
                node.position = CGPointMake(castle.pCurrent.x, castle.pCurrent.y + 32);
                
                if(c != nrTilesToDraw - 1)
                {
                    delta = CGVectorMake(node.size.width, 0);
                    castle.pCurrent = CGPointMake(castle.pCurrent.x - delta.dx, castle.pCurrent.y + delta.dy);
                }
                [castle addPart:node];
            }
            else if([command compare:@"s"] == 0)
            {
            
            }
        }
        
        commandOld = command;
    }

    return castle;
}

-(void)addPart:(SKSpriteNode*) part
{
    part.anchorPoint = CGPointMake(0, 0);
    part.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, part.size.width/2, part.size.height/2)];
    part.physicsBody.affectedByGravity = false;
    part.physicsBody.dynamic = false;
    
    [self addChild:part];
    
    //for debugging
    UIColor *col = [UIColor blackColor];
    
    switch (self.nrColor)
    {
        case 1:
            col = [UIColor redColor];
            break;
        case 2:
            col = [UIColor blueColor];
            break;
        case 3:
            col = [UIColor yellowColor];
            break;
        default:
            break;
    }
    
    self.nrColor++;
    
    if(self.nrColor == 4)
        self.nrColor = 1;
    
    SKSpriteNode *helper = [SKSpriteNode spriteNodeWithColor:col size:CGSizeMake(100, 100)];
    helper.anchorPoint = CGPointMake(0, 0);
    [part addChild:helper];
    
    
}


@end
