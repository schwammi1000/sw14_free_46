//
//  PODGamePadNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 14.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODGamePadNode.h"

@implementation PODGamePadNode

+(instancetype)createGamePad
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Gamepad"];
    PODGamePadNode *gamepad = [[PODGamePadNode alloc] initWithTexture:[atlas textureNamed:@"Gamepad"]];
    
    gamepad.cursor = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"Cursor"]];
    
    gamepad.cursor.position = CGPointMake(gamepad.size.width/2, gamepad.size.height/2);
    
    gamepad.anchorPoint = CGPointMake(0, 0);
    gamepad.position = CGPointMake(500, 50);
    
    [gamepad addChild:gamepad.cursor];
    
    gamepad.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(100, 100, 200, 200)];
    gamepad.cursor.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10 center:CGPointMake(10, 10)];
    gamepad.physicsBody.affectedByGravity = false;
    gamepad.cursor.physicsBody.affectedByGravity = false;
    
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
