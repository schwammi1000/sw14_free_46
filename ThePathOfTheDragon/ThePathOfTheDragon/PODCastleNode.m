//
//  PODCastleNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 31.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODCastleNode.h"
#import "PODCollisionHandling.h"
#import "PODBuildHandling.h"

@implementation PODCastleNode

+(instancetype)getPreassembledCastleWithNr:(int)number
{
    PODCastleNode *castle;
    
    switch (number)
    {
        case 1:
            castle = [PODCastleNode createCastleWithCode:@"u 2 r 2 d 2 l 2"];
            if(castle.buildable)
                return castle;
            break;
        case 2:
            castle = [PODCastleNode createCastleWithCode:@"u 2 l 1 u 4 r 6 d 4 l 1 d 2 l 4"];
            if(castle.buildable)
                return castle;
            break;
        case 3:
            castle = [PODCastleNode createCastleWithCode:@"l 9 u 10 r 1 d 1 r 1 d 1 r 1 d 1 r 2 u 6 l 2 u 2 r 10 d 2 l 2 d 6 r 2 u 1 r 1 u 1 r 1 u 1 r 1 d 10 l 9 s 1"];
            if(castle.buildable)
                return castle;
            break;
        default: return nil;
    }
    
    return nil;
}

+(instancetype)createCastleWithCode:(NSString *)code
{
    PODCastleNode *castle = [[PODCastleNode alloc] init];
    
    if(castle == nil)
        return nil;
    
    castle.atlas = [SKTextureAtlas atlasNamed:@"Castle"];
    castle.pCurrent = CGPointMake(0, 0);
    
    castle.buildHandling = [[PODBuildHandling alloc] init];
    castle.buildable = true;
    
    NSArray *commands = [code componentsSeparatedByString:@" "];
    
    for(NSUInteger i = 0; i < [commands count]; i += 2)
    {
        NSString *command = [commands objectAtIndex:i];
        int nrTilesToDraw = 0;
        
        nrTilesToDraw = [[commands objectAtIndex:i+1] intValue];
        
        if(i == 0)
            [castle startBuildingToDirection:[castle getDirectionFromString:command]];
        else if([command compare:@"s"] != 0)
            [castle buildCornerToDirection:[castle getDirectionFromString:command]];
        
        for(int c = 0; c < nrTilesToDraw; c++)
        {
            if([command compare:@"u"] == 0)
                [castle buildUp];
 
            else if([command compare:@"d"] == 0)
                [castle buildDown];

            else if([command compare:@"r"] == 0)
                [castle buildRight];
            
            else if([command compare:@"l"] == 0)
                [castle buildLeft];

            else if([command compare:@"s"] == 0)
                [castle stopBuilding];
        }
    }

    castle.zPosition = 20;
    return castle;
}

-(void)buildCornerToDirection:(Direction)newDirection
{
    switch (self.currentDirection)
    {
        case UP:
            self.pCurrent = CGPointMake(self.pCurrent.x - 23, self.pCurrent.y);
            [self addChild:[self getCastleNodeWithTexture:@"TowerTop"]];
            
            if(newDirection == LEFT)
                self.pCurrent = CGPointMake(self.pCurrent.x, self.pCurrent.y + 32);
                    
            else if (newDirection == RIGHT)
                self.pCurrent = CGPointMake(self.pCurrent.x + [self getCastleNodeWithTexture:@"TowerTop"].size.width, self.pCurrent.y + 32);
            
            break;
            
            
        case DOWN:
            
            self.pCurrent = CGPointMake(self.pCurrent.x - 23, self.pCurrent.y - [self getCastleNodeWithTexture:@"TowerBottom"].size.height);
            [self addChild:[self getCastleNodeWithTexture:@"TowerBottom"]];
            
            if(newDirection == LEFT)
                self.pCurrent = CGPointMake(self.pCurrent.x, self.pCurrent.y + 32);
            
            else if (newDirection == RIGHT)
                self.pCurrent = CGPointMake(self.pCurrent.x + [self getCastleNodeWithTexture:@"TowerBottom"].size.width, self.pCurrent.y + 32);
            
            break;
            
            
        case LEFT:
            
            if(newDirection == UP)
            {
                self.pCurrent = CGPointMake(self.pCurrent.x - [self getCastleNodeWithTexture:@"TowerBottom"].size.width, self.pCurrent.y - 32);
                [self addChild:[self getCastleNodeWithTexture:@"TowerBottom"]];
                self.pCurrent = CGPointMake(self.pCurrent.x + 23, self.pCurrent.y + [self getCastleNodeWithTexture:@"TowerBottom"].size.height);
            }
            else if(newDirection == DOWN)
            {
                self.pCurrent = CGPointMake(self.pCurrent.x - [self getCastleNodeWithTexture:@"TowerTop"].size.width, self.pCurrent.y - 32);
                [self addChild:[self getCastleNodeWithTexture:@"TowerTop"]];
                self.pCurrent = CGPointMake(self.pCurrent.x + 23, self.pCurrent.y);
            }
            break;
            
            
        case RIGHT:
            
            self.pCurrent = CGPointMake(self.pCurrent.x, self.pCurrent.y - 32);
            
            if(newDirection == UP)
            {
                [self addChild:[self getCastleNodeWithTexture:@"TowerBottom"]];
                self.pCurrent = CGPointMake(self.pCurrent.x + 23, self.pCurrent.y + [self getCastleNodeWithTexture:@"TowerBottom"].size.height);
            }
            else if(newDirection == DOWN)
            {
                [self addChild:[self getCastleNodeWithTexture:@"TowerTop"]];
                self.pCurrent = CGPointMake(self.pCurrent.x + 23, self.pCurrent.y);
            }

            break;
    }
    
    self.currentDirection = newDirection;
}

-(void)buildUp
{
    [self addChild:[self getCastleNodeWithTexture:@"WallVerticalLong"]];
    self.pCurrent = CGPointMake(self.pCurrent.x, self.pCurrent.y + [self getCastleNodeWithTexture:@"WallVerticalLong"].size.height);
    self.currentDirection = UP;
}

-(void)buildDown
{
    self.pCurrent = CGPointMake(self.pCurrent.x, self.pCurrent.y - [self getCastleNodeWithTexture:@"WallVerticalLong"].size.height);
    [self addChild:[self getCastleNodeWithTexture:@"WallVerticalLong"]];
    self.currentDirection = DOWN;
}

-(void)buildLeft
{
    self.pCurrent = CGPointMake(self.pCurrent.x - [self getCastleNodeWithTexture:@"WallHorizontal"].size.width, self.pCurrent.y);
    [self addChild:[self getCastleNodeWithTexture:@"WallHorizontal"]];
    self.currentDirection = LEFT;
}

-(void)buildRight
{
    [self addChild:[self getCastleNodeWithTexture:@"WallHorizontal"]];
    self.pCurrent = CGPointMake(self.pCurrent.x + [self getCastleNodeWithTexture:@"WallHorizontal"].size.width, self.pCurrent.y);
    self.currentDirection = RIGHT;
}

-(void)startBuildingToDirection:(Direction)direction
{
    switch (direction)
    {
        case UP:
            [self addChild:[self getCastleNodeWithTexture:@"TowerBottom"]];
            self.pCurrent = CGPointMake(self.pCurrent.x + 23, self.pCurrent.y + [self getCastleNodeWithTexture:@"TowerBottom"].size.height);
            break;
            
        case DOWN:
            [self addChild:[self getCastleNodeWithTexture:@"TowerTop"]];
            self.pCurrent = CGPointMake(self.pCurrent.x + 23, self.pCurrent.y);
            break;
            
        case LEFT:
            [self addChild:[self getCastleNodeWithTexture:@"Tower"]];
            self.pCurrent = CGPointMake(self.pCurrent.x, self.pCurrent.y + 32);
            break;
            
        case RIGHT:
            [self addChild:[self getCastleNodeWithTexture:@"Tower"]];
            self.pCurrent = CGPointMake(self.pCurrent.x + [self getCastleNodeWithTexture:@"Tower"].size.width, self.pCurrent.y + 32);
            break;
    }
}

-(void)stopBuilding
{
    switch (self.currentDirection)
    {
        case UP:
            self.pCurrent = CGPointMake(self.pCurrent.x - 23, self.pCurrent.y);
            [self addChild:[self getCastleNodeWithTexture:@"TowerTop"]];
            break;
            
        case DOWN:
            self.pCurrent = CGPointMake(self.pCurrent.x - 23, self.pCurrent.y - [self getCastleNodeWithTexture:@"TowerBottom"].size.height);
            [self addChild:[self getCastleNodeWithTexture:@"TowerBottom"]];
            break;
            
        case LEFT:
            self.pCurrent = CGPointMake(self.pCurrent.x - [self getCastleNodeWithTexture:@"Tower"].size.width, self.pCurrent.y - 32);
            [self addChild:[self getCastleNodeWithTexture:@"Tower"]];
            break;
            
        case RIGHT:
            self.pCurrent = CGPointMake(self.pCurrent.x, self.pCurrent.y - 32);
            [self addChild:[self getCastleNodeWithTexture:@"Tower"]];
            break;
    }
}

-(SKSpriteNode*)getCastleNodeWithTexture:(NSString*)name
{
    SKSpriteNode *castleNode = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:name]];
    
    castleNode.anchorPoint = CGPointMake(0, 0);
    castleNode.position = self.pCurrent;
    
    if([name compare:@"Tower"] == 0 || [name compare:@"TowerTop"] == 0)
        castleNode.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, castleNode.size.width, 108)];
    else if([name compare:@"WallHorizontal"] == 0)
        castleNode.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, castleNode.size.width, 42)];
    else
        castleNode.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, castleNode.size.width, castleNode.size.height)];
    
    castleNode.physicsBody.affectedByGravity = false;
    castleNode.physicsBody.dynamic = false;
    
    if(![self.buildHandling isBuildable:castleNode])
        self.buildable = false;
    
    return castleNode;
}

-(Direction)getDirectionFromString:(NSString*)string
{
    if([string compare:@"u"] == 0)
        return UP;
    
    if([string compare:@"d"] == 0)
        return DOWN;
    
    if([string compare:@"r"] == 0)
        return RIGHT;
    
    if([string compare:@"l"] == 0)
        return LEFT;
    
    return UP;
}

@end
