//
//  PODMyScene.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 31.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODGameScene.h"

@implementation PODGameScene

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    if(self == nil)
        return nil;
    
    self.game = [PODGameNode createGame];
    
    [self addChild:self.game];
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    CGVector delta = CGVectorMake(location.x - self.game.hero.position.x, location.y - self.game.hero.position.y);
    
    if(fabs(delta.dx) >= fabs(delta.dy))
        delta = CGVectorMake(128 * delta.dx/fabs(delta.dx), 0);
    else
        delta = CGVectorMake(0, 128 * delta.dy/fabs(delta.dy));
    
    
    [self.game moveHeroRelative:delta];
}

-(void)update:(CFTimeInterval)currentTime
{
    
}

-(void)didMoveToView:(SKView *)view
{
    
}

@end