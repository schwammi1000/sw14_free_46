//
//  PODCollisionHandling.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 08.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

#define SPRITE (0x01 << 0)
#define COIN (0x01 << 1)

@class PODHero;

@interface PODCollisionHandling : NSObject <SKPhysicsContactDelegate>

@property PODHero *hero;

-(instancetype)initWithHero:(PODHero*)hero;

@end
