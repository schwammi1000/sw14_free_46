//
//  PODTestGamePadNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 17.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PODGamePadNode.h"

@interface PODTestGamePadNode : XCTestCase

@property PODGamePadNode *gamepad;

@end

@implementation PODTestGamePadNode

- (void)setUp
{
    [super setUp];
    
    self.gamepad = [PODGamePadNode createGamePadAtPosition:CGPointMake(500, 500)];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateGamepad
{
    if(self.gamepad == nil)
        XCTFail(@"Creating gamepad failed");
    
    if(self.gamepad.cursor == nil)
        XCTFail(@"No cursor in the gamepad");
    
    if(self.gamepad.cursor.position.x != self.gamepad.size.width / 2 || self.gamepad.cursor.position.y != self.gamepad.size.height / 2)
        XCTFail(@"Cursor is not in the middle");
    
    if(self.gamepad.cursor.zPosition != 100)
        XCTFail(@"Cursor has wrong z-Position");
    
    if(self.gamepad.zPosition != 99)
        XCTFail(@"Gamepad has wrong z-Position");
    
    if(self.gamepad.anchorPoint.x != 0 || self.gamepad.anchorPoint.y != 0)
        XCTFail(@"Gamepad has wrong anchor point");
    
    if(self.gamepad.position.x != 500  - self.gamepad.size.width / 2 || self.gamepad.position.y != 500  - self.gamepad.size.height / 2)
        XCTFail(@"Gamepad has wrong position");
    
    if([[self.gamepad children] count] != 1)
        XCTFail(@"Gamepad has no cursor");
}

@end
