//
//  PODGamePadNode.h
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 14.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PODGamePadNode : SKSpriteNode

@property SKSpriteNode *cursor;

+(instancetype)createGamePad;
-(void)setPositionWithTouch:(NSSet *)touches;
-(CGVector)calculateNewMovingDirectionWithTouch:(NSSet *)touches;

@end
