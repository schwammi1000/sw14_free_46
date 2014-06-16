//
//  PODGamePadNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 14.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODGamePadNode.h"

@implementation PODGamePadNode

+(instancetype)createGamePadAtPosition:(CGPoint)position
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Gamepad"];
    PODGamePadNode *gamepad = [[PODGamePadNode alloc] initWithTexture:[atlas textureNamed:@"Gamepad"]];
    
    gamepad.cursor = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"Cursor"]];
    gamepad.cursor.position = CGPointMake(gamepad.size.width/2, gamepad.size.height/2);
    gamepad.cursor.zPosition = 100;
    
    gamepad.anchorPoint = CGPointMake(0, 0);
    gamepad.position = CGPointMake(position.x - gamepad.size.width / 2, position.y - gamepad.size.height / 2);
    gamepad.zPosition = 99;
    
    [gamepad addChild:gamepad.cursor];
    
    return gamepad;
}

-(void)setPositionWithTouch:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchlocation = [touch locationInNode:self];
    
    self.cursor.position = touchlocation;
}

-(CGVector)calculateNewMovingDirectionWithTouch:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchlocation = [touch locationInNode:self];
    CGVector newMovingDirection = CGVectorMake(touchlocation.x - self.size.width/2, touchlocation.y - self.size.height/2);
    
    if(fabs(newMovingDirection.dx) >= fabs(newMovingDirection.dy))
        newMovingDirection = CGVectorMake(newMovingDirection.dx/fabs(newMovingDirection.dx), 0);
    else
        newMovingDirection = CGVectorMake(0, newMovingDirection.dy/fabs(newMovingDirection.dy));
    
    return newMovingDirection;
}

@end
