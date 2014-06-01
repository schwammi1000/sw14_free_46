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
    
    //Setup atlas
    self.atlas = [SKTextureAtlas atlasNamed:@"Background"];
    
    //Setup root
    self.root = [[SKNode alloc] init];
    [self.root setPosition:CGPointMake(0.0, 0.0)];
    
    //Create map
    PODMapNode *map = [PODMapNode createMapWithSize:CGSizeMake(16, 16) Tilesize:CGSizeMake(1024, 1024) Texture:@"DesertXLarge"];
    
    //Add map to root
    [self.root addChild:map];
    
    //Create castle
    PODCastleNode *castle = [PODCastleNode castleWithSize:CGSizeMake(0, 0) Complexity:0];
    
    //Add castle to map
    [map addCastle:castle At:CGPointMake(200, 200)];
    
    //Add root to scene
    [self addChild:self.root];
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.root.position = CGPointMake(self.root.position.x - 100, self.root.position.y - 100);
}

-(void)update:(CFTimeInterval)currentTime
{

}

-(void)didMoveToView:(SKView *)view
{

}

@end
