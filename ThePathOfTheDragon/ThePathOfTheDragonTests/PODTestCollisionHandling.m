//
//  PODTestCollisionHandling.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 17.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PODCollisionHandling.h"
#import "PODHero.h"


@interface PODTestCollisionHandling : XCTestCase

@property PODCollisionHandling *collisionHandling;

@end

@implementation PODTestCollisionHandling

- (void)setUp
{
    [super setUp];
    
    self.collisionHandling = [[PODCollisionHandling alloc] initWithHero:[PODHero createHeroWithNeededCoins:500]];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testPresenceOfHero
{
    if(self.collisionHandling.hero == nil)
        XCTFail(@"Assigning hero to collison instance does no work");
}

@end
