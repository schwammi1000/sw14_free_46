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

@interface PODGameScene : SKScene

@property PODGameNode *game;
@property SKLabelNode *label;

@end
