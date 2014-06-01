//
//  PODRiverNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PODRiverNode : SKNode

@property SKTextureAtlas *atlas;
+(instancetype)createRiver: (int)start_point;

@end
