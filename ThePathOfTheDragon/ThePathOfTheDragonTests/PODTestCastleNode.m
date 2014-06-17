//
//  PODTestCastleNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 17.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <XCTest/XCTest.h>
#include "PODCastleNode.h"

@interface PODTestCastleNode : XCTestCase

@end

@implementation PODTestCastleNode

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBuildCastleNode
{
    PODCastleNode *castle = [PODCastleNode createCastleWithCode:@"u 2 l 3 d 4 r 5 s 1"];
    
    if(castle == nil)
        XCTFail(@"Impossible to create castle");
    
    if([[castle children] count] != 19)
        XCTFail(@"Built castle is no plausible");
    
    if(castle.currentDirection != RIGHT)
        XCTFail(@"Direction at the end is wrong, maybe the implementation is wrong");
    
}

@end
