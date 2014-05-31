//
//  POTDMyScene.m
//  PathOfTheDragon
//
//  Created by Markus Kammerhofer on 30.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "POTDMyScene.h"

@implementation POTDMyScene
int x = 0;
int y = -14336;

-(id)initWithSize:(CGSize)size
{
    if (!(self = [super initWithSize:size]))
        return nil;
    
    //Prepare Background
    self.background = [SKSpriteNode spriteNodeWithImageNamed:@"Map.png"];
    self.background.zPosition = 1.0;
    [self addChild:self.background];
    
    //Prepare Top
    self.top = [JSTileMap mapNamed:@"Map.tmx"];
    self.top.zPosition = 2.0;
    [self addChild:self.top];
    //self.top.position = CGPointMake(-500.0, -500.0);
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

-(void)didMoveToView:(SKView *)view
{
    
}

@end
