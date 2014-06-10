//
//  PODCastleNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 31.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PODCollisionHandling.h"

@interface PODCastleNode : SKNode

@property SKTextureAtlas *atlas;
@property int nrColor;
@property CGPoint pCurrent;

+(instancetype)getPreassembledCastleWithNr:(int)number;
+(instancetype)createCastleWithCode:(NSString *)code;

@end
