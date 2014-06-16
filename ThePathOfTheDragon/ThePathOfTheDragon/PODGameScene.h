//
//  PODMyScene.h
//  ThePathOfTheDragon
//

//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "PODCastleNode.h"
#import "PODRiverNode.h"
#import "PODGameNode.h"
#import "PODCollisionHandling.h"
#import "PODGamePadNode.h"
#import "PODCoinNode.h"

@interface PODGameScene : SKScene

@property PODGameNode *game;
@property PODGamePadNode *gamepad;
@property SKLabelNode *scoreLabel;
@property SKSpriteNode *buttonRestart;

@end
