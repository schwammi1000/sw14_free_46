//
//  POTDMyScene.h
//  PathOfTheDragon
//

//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "JSTileMap.h"

@interface POTDMyScene : SKScene

@property (nonatomic, strong) JSTileMap *top;
@property (nonatomic, strong) SKSpriteNode* background;

@end
