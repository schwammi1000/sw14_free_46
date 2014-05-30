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
    self.curFrame = CGRectMake (x,y,15360,15360);
    self.imgView = [[UIImageView alloc] initWithFrame:self.curFrame];
    self.mapbackground = [UIImage imageNamed:@"Map.png"];
    self.imgView.image = self.mapbackground;
    
    
    //Prepare Map
    self.map = [JSTileMap mapNamed:@"Map.tmx"];
    [self addChild:self.map];
    self.map.position = CGPointMake(-500.0, -500.0);
    
    
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.curFrame = CGRectMake (0,0,15360,15360);
    self.imgView2 = [[UIImageView alloc] initWithFrame:self.curFrame];
    self.imgView2.image = self.mapbackground;
    [self.view addSubview:self.imgView2];
    
    
    [self.imgView removeFromSuperview];
    self.curFrame = CGRectMake (x,y,15360,15360);
    self.imgView = [[UIImageView alloc] initWithFrame:self.curFrame];
    self.imgView.image = self.mapbackground;
    [self.view addSubview:self.imgView];
    
    x += 100;
    y += 20;
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

@end
