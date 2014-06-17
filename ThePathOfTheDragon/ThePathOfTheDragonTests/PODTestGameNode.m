//
//  PODTestGameNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 17.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PODGameNode.h"

@interface PODTestGameNode : XCTestCase

@property PODGameNode *game;

@end

@implementation PODTestGameNode

- (void)setUp
{
    [super setUp];
    self.game = [PODGameNode createGame];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateGame
{
    if(self.game == nil)
        XCTFail(@"Creating map is no working");
    
    if(self.game.anchorPoint.x != 0 || self.game.anchorPoint.y != 0)
        XCTFail(@"Wrong anchorpoint");
    
    if(self.game.position.x != 0 || self.game.position.y != 0)
        XCTFail(@"Wrong position");
    
    if(self.game.hero == nil)
        XCTFail(@"Did not creat a hero");
    
    if(self.game.map.parent != self.game)
        XCTFail(@"Map is not a child of game");
    
    if(self.game.hero.parent != self.game)
        XCTFail(@"Hero is not a child of game");
    
    if(self.game.physicsBody == nil)
        XCTFail(@"The map has no border");
}

@end
