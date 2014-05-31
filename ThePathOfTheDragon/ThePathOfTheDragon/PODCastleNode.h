//
//  PODCastleNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 31.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PODCastleNode : SKNode

@property SKTextureAtlas *atlas;

+(instancetype)castleWithSize:(CGSize)size Complexity:(NSNumber*)complexity;

@end
