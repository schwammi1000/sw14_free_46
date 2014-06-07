//
//  PODGameNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PODMapNode.h"
#import "PODCastleNode.h"
#import "PODRiverNode.h"

@interface PODGameNode : SKSpriteNode

@property PODMapNode *map;
@property SKSpriteNode *hero;
@property NSArray *hero_walking_frames_left;
@property NSArray *hero_walking_frames_right;
@property NSArray *hero_walking_frames_up;
@property NSArray *hero_walking_frames_down;


+(instancetype)createGame;
-(void)moveHeroRelative:(CGVector)movement;

@end
