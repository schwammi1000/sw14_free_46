//
//  PODTestHero.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 10.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PODHero.h"

@interface PODTestHero : XCTestCase

@property PODHero *hero;

@end

@implementation PODTestHero

- (void)setUp
{
    [super setUp];
    
    self.hero = [PODHero createHeroWithNeededCoins:100];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreatingHero
{
    if(self.hero.texture == nil)
        XCTFail(@"Hero without texture created");
    
    if(self.hero.size.width != self.hero.size.height)
        XCTFail(@"Hero has wrong proportions");
    
    if(self.hero.anchorPoint.x != 0 || self.hero.anchorPoint.y != 0)
        XCTFail(@"Hero needs anchorPoint(0,0)");
    
    if(self.hero.physicsBody == nil)
        XCTFail(@"Hero has no physics body");
    
    if(self.hero.physicsBody.affectedByGravity == true)
        XCTFail(@"Hero is affected by gravity");
    
    if(self.hero.neededCoins != 100)
        XCTFail(@"Number of needed coins is wrong");
    
    if(self.hero.hero_walking_frames_down == nil ||
       self.hero.hero_walking_frames_up == nil ||
       self.hero.hero_walking_frames_left == nil ||
       self.hero.hero_walking_frames_right == nil)
        XCTFail(@"Animation set-up failed");
}

- (void)testMoveHero
{
    [self.hero moveHero:CGVectorMake(0, 0)];
    if([self.hero hasActions])
        XCTFail(@"Hero is not allowed to move with (0,0)");
    
    [self.hero moveHero:CGVectorMake(0, 1)];
    if(![self.hero hasActions])
        XCTFail(@"Hero does not move");
}

- (void)testChangeMovingDirection
{
    [self.hero changeMovingDirection:CGVectorMake(0, 1)];
    
    if(![self.hero hasActions])
        XCTFail(@"Hero does not move");
}

- (void)testStopHero
{
    [self.hero stopHero];
    
    if([self.hero hasActions])
        XCTFail(@"Hero is still moving");
}

- (void)testSetSpeed
{
    [self.hero setSpeed:(MAX_SPEED + 10)];
    if(self.hero.runningDurationOfOneAnimation <= 0.2)
        XCTFail(@"Wrong maximum calculation");
    
    [self.hero setSpeed:(MIN_SPEED - 10)];
    if(self.hero.runningDurationOfOneAnimation >= 1)
        XCTFail(@"Wrong minimum calculation");
}

@end
