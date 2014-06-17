//
//  PODTestMapNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 17.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PODMapNode.h"

#define TILE_WIDTH 1024
#define TILE_HEIGHT 1024
#define NR_TILES_X 16
#define NR_TILES_Y 16

@interface PODTestMapNode : XCTestCase

@property PODMapNode *map;

@end

@implementation PODTestMapNode

- (void)setUp
{
    [super setUp];
    
    self.map = [PODMapNode createMapWithSize:CGSizeMake(NR_TILES_X, NR_TILES_Y) Tilesize:CGSizeMake(TILE_WIDTH, TILE_HEIGHT) Texture:@"DesertXLarge"];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreatingMap
{
    if(self.map.background == nil)
        XCTFail(@"Background-Node not initialized");
    
    if(self.map.rivers == nil)
        XCTFail(@"River-Node not initialized");
    
    if(self.map.castles == nil)
        XCTFail(@"Castle-Node not initialized");
    
    if(self.map.coins == nil)
        XCTFail(@"Coin-Node not initialized");
    
    if(self.map.atlas == nil)
        XCTFail(@"Atlas is not used, needed for drawing the map");
    
    if([[self.map.background children] count] != NR_TILES_X * NR_TILES_Y)
        XCTFail(@"Wrong creating of Background, too many or too less tiles");
    
    if(self.map.anchorPoint.x != 0 || self.map.anchorPoint.y != 0)
        XCTFail(@"Wrong anchor point");
}

-(void)testAddCastle
{
    PODCastleNode *castle1 = [PODCastleNode getPreassembledCastleWithNr:1];
    PODCastleNode *castle2 = [PODCastleNode getPreassembledCastleWithNr:2];
    
    [self.map addCastle:castle1 At:CGPointMake(100, 100)];
    [self.map addCastle:castle2 At:CGPointMake(1000, 1000)];
    
    if([[self.map.castles children] count] != 2)
        XCTFail(@"Adding castles failed");
    
    if(castle1.position.x != 100 || castle1.position.y != 100)
        XCTFail(@"Setting n1 castles position failed");
    
    if(castle2.position.x != 1000 || castle2.position.y != 1000)
        XCTFail(@"Setting n2 castles position failed");
}

-(void)testAddRiver
{
    PODRiverNode *river = [PODRiverNode createRiver:(1024*16)TileSize:32];
    
    [self.map addRiver:river At:CGPointMake(0, 0)];
    
    if([[self.map.rivers children] count] != 1)
        XCTFail(@"Adding river failed");
    
    if(river.position.x != 0 || river.position.y != 0)
        XCTFail(@"Setting rivers position failed");
}

-(void)testAddCoins
{
    [self.map add:500 CoinsWithStartValue:0];
    
    if([[self.map.coins children] count] != 500)
        XCTFail(@"Added wrong number of coins");
}

-(void)testPossibilityMethod
{
    float percentageShould = 70;
    float percentageIs;
    int count = 0;
    
    for(int i = 0; i < 1000000; i++)
    {
        if([self.map possibilityOf:percentageShould] == true)
            count++;
    }
    
    percentageIs = count / 1000000.0;
    percentageIs *= 100;
    
    if(percentageIs > percentageShould + 10 || percentageIs < percentageShould - 10)
        XCTFail(@"RandomMethod does not work");
        
}

@end
