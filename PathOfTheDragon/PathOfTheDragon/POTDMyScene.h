//
//  POTDMyScene.h
//  PathOfTheDragon
//

//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "JSTileMap.h"

@interface POTDMyScene : SKScene

@property (nonatomic, strong) JSTileMap *map;
@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UIImageView* imgView2;
@property (nonatomic, strong) UIImage* mapbackground;
@property CGRect curFrame;

@end
