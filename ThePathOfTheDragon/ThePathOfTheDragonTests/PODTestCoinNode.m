//
//  PODTestCoinNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 17.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PODCoinNode.h"

@interface PODTestCoinNode : XCTestCase

@property PODCoinNode *coin;

@end

@implementation PODTestCoinNode

- (void)setUp
{
    [super setUp];
    
    self.coin = [PODCoinNode createCoin];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateCoin
{
    if(self.coin == nil)
        XCTFail(@"Creating coin did not work");
    
    if([[self.coin children] count] != 2)
        XCTFail(@"Structure of Coin is wrong");
    
    if([[self.coin children][1] hasActions] == false)
        XCTFail(@"Coin does not rotate");
}

@end
