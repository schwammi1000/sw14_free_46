//
//  PODHero.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 09.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PODCollisionHandling.h"

@interface PODHero : SKSpriteNode

@property NSArray *hero_walking_frames_left;
@property NSArray *hero_walking_frames_right;
@property NSArray *hero_walking_frames_up;
@property NSArray *hero_walking_frames_down;

@property int rangeOfOneClick;

+(instancetype)createHero;
-(void)moveHeroRelative:(CGVector)movement;

@end
