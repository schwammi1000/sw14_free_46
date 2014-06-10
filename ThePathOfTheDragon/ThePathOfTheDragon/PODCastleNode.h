//
//  PODCastleNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 31.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PODCollisionHandling.h"

typedef enum Direction{UP, DOWN, LEFT, RIGHT} Direction;

@interface PODCastleNode : SKNode

@property SKTextureAtlas *atlas;

@property CGPoint pCurrent;
@property Direction currentDirection;

+(instancetype)getPreassembledCastleWithNr:(int)number;
+(instancetype)createCastleWithCode:(NSString *)code;

@end
