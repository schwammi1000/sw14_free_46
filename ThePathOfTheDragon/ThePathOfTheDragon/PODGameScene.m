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
    SKNode *map = [self createMapWithSize:CGSizeMake(40, 40) Tilesize:CGSizeMake(32, 32) Texture:@"Desert"];
    
    //Add map to root
    [self.root addChild:map];
    
    //Create castle
    PODCastleNode *castle = [PODCastleNode castleWithSize:CGSizeMake(0, 0) Complexity:0];
    castle.position = CGPointMake(200, 200);
    
    //Add castle to root
    [self.root addChild:castle];
    
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
    printf("Finished Loading\n");
}

-(SKNode *)createMapWithSize:(CGSize)mapSize Tilesize:(CGSize)tileSize Texture:(NSString *)name
{
    SKNode *map = [[SKNode alloc] init];
    SKTexture *texture = [self.atlas textureNamed:name];
    
    for(int x = 0; x < mapSize.width; x++)
    {
        for(int y = 0; y < mapSize.height; y++)
        {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture size:tileSize];
            [node setAnchorPoint:CGPointMake(0.0, 0.0)];
            [node setPosition:CGPointMake(x * tileSize.width, y * tileSize.height)];
            [map addChild:node];
        }
    }
    
    [map setPosition:CGPointMake(0, 0)];
    
    return map;
}

@end
