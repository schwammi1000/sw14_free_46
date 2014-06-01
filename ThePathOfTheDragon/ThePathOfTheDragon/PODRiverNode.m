//
//  PODRiverNode.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODRiverNode.h"

@implementation PODRiverNode

int WIDTH_OF_RIVER = 5;


+(instancetype)createRiver:(int)start_point
{
    int start_point_x;
    int start_point_y;
    int start_side = 0;
    int finish_side = 0;
    CGPoint point;
    
    
    
    PODRiverNode *river_node = [[PODRiverNode alloc] init];
    
    if(!river_node)
        return nil;
    
    //Define Start and Finish
    [river_node calculateStartAndEndSide:&start_side End:&finish_side];
    printf("Zufallsseite: %d ... %d\n", start_side, finish_side);
    
    
    //Create Start_Point of river
    //start_point_x = ((arc4random() % start_point) + 1);
    start_point_x = 251;
    printf("Zufallszahl: %d\n", start_point_x);
    
    //Create atlas
    river_node.atlas = [SKTextureAtlas atlasNamed:@"Background"];
    
    //Create vertical river
    point = [river_node verticalConstruct:start_point_x YValue:0 Length:20];
    
    //Create horizontal river
    point = [river_node horizontalConstruct:point.x YValue:point.y Length:20];
    
    //Create vertical river
    point = [river_node verticalConstruct:point.x YValue:point.y Length:20];
    
    return river_node;
    
}

-(CGPoint)verticalConstruct: (int)start_point_x YValue: (int)start_point_y Length: (int)length
{
    int x = start_point_x;
    int y = start_point_y;
    CGPoint last_point;
    
    for(int i = 0; i < length; i++)
    {
        x = start_point_x;
        
        for(int j = 0; j < WIDTH_OF_RIVER; j++)
        {
            SKSpriteNode *river_sprite = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"Water"]size:CGSizeMake(32, 32)];
                [river_sprite setAnchorPoint:CGPointMake(0.0, 0.0)];

            [river_sprite setPosition:CGPointMake(x, y)];
            [self addChild:river_sprite];
            
            x += 32;
        }
        y += 32;
    }
    
    last_point = CGPointMake((x - 32*WIDTH_OF_RIVER), y);
    //last_point = CGPointMake(x, y);
    printf("CGPOINT_VERT: %f ... %f\n", last_point.x, last_point.y);
    return last_point;
}

-(CGPoint)horizontalConstruct: (int)start_point_x YValue: (int)start_point_y Length: (int)length
{
    int x = start_point_x;
    int y = start_point_y;
    CGPoint last_point;
  
    for(int i = 0; i < length; i++)
    {
        y = start_point_y;
        
        for(int j = 0; j < WIDTH_OF_RIVER; j++)
        {
            SKSpriteNode *river_sprite = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"Water"]size:CGSizeMake(32, 32)];
            [river_sprite setAnchorPoint:CGPointMake(0.0, 0.0)];
            
            [river_sprite setPosition:CGPointMake(x, y)];
            [self addChild:river_sprite];
            
            y += 32;
        }
        x += 32;
    }
    
    last_point = CGPointMake(x, (y - 32*WIDTH_OF_RIVER));
    //last_point = CGPointMake(x, y);
    printf("CGPOINT_HOR: %f ... %f\n", last_point.x, last_point.y);
    return last_point;
    
}

-(void)calculateStartAndEndSide: (int*)start_side End: (int*)finish_side
{
    //Calculate Start: 1...left Side
    //                 2...right Side
    //                 3...bottom
    //                 4...top
    
    *start_side = ((arc4random() % 4) + 1);
    
    do
    {
       *finish_side = ((arc4random() % 4) + 1);
    }
    while (*start_side == *finish_side);

}

@end