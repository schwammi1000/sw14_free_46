//
//  PODTestRiverNode.m
//  ThePathOfTheDragon
//
//  Created by Michael Jantscher on 17/06/14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PODRiverNode.h"

@interface PODTestRiverNode : XCTestCase

@end

@implementation PODTestRiverNode

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testRiverNode
{
    PODRiverNode *river = [PODRiverNode createRiver:(1024 * 16) TileSize:32];
    int minimum_tiles = 0;
    
    minimum_tiles = ((1024 * 16)/32)/2;
    minimum_tiles = minimum_tiles * 5;
    
    if(river == nil)
        XCTFail(@"Couldn't create River");
    
    if([[river children] count] < minimum_tiles)
        XCTFail(@"River couldn't exist in this form");
    
    if(river.shape_right.position.x < 0 || river.shape_right.position.x > (1024 * 16))
        XCTFail(@"Shape_right is not on right position");
    
    if(river.shape_right.position.y < 0 || river.shape_right.position.y > (1024 * 16))
        XCTFail(@"Shape_right is not on right position");
    
    if(river.shape_left.position.x < 0 || river.shape_left.position.x > (1024 * 16))
        XCTFail(@"Shape_left is not on right position");
    
    if(river.shape_left.position.y < 0 || river.shape_left.position.y > (1024 * 16))
        XCTFail(@"Shape_left is not on right position");
}

@end
