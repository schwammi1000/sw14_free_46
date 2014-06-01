//
//  PODGameNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PODMapNode.h"

@interface PODGameNode : SKNode

@property PODMapNode *map;
@property SKSpriteNode *hero;

+(instancetype)createGame;
-(void)moveHeroRelative:(CGVector)movement;

@end
