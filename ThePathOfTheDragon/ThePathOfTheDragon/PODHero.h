//
//  PODHero.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 09.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


#define MAX_SPEED 100
#define MIN_SPEED 20

@class PODCollisionHandling;

@interface PODHero : SKSpriteNode

@property NSArray *hero_walking_frames_left;
@property NSArray *hero_walking_frames_right;
@property NSArray *hero_walking_frames_up;
@property NSArray *hero_walking_frames_down;

@property int rangeOfOneAnimation;
@property float runningDurationOfOneAnimation;
@property int nrOfAnimationTextures;

@property int attributeSpeed;
@property int coins;

@property CGVector actualMovingDirection;

+(instancetype)createHero;
-(void)moveHero:(CGVector)newMovingDirection;
-(void)stopHero;
-(void)changeMovingDirection:(CGVector)newMovingDirection;
-(void)foundCoin;

- (void)setSpeed:(int)speed;

@end
