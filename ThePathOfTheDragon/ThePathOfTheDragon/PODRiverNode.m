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

+(instancetype)createRiver:(int)map_size TileSize: (int)tile_size
{
    int start_point_x;
    int calc_y = 0;
    int direction = 0;
    int range = 0;
    int length = 0;
    int direction_old = 0;
    int start = 0;
    CGPoint point;
    
    
    
    PODRiverNode *river_node = [[PODRiverNode alloc] init];
    
    if(!river_node)
        return nil;

    start_point_x = map_size/2; //256;
    
    //Create atlas
    river_node.atlas = [SKTextureAtlas atlasNamed:@"Background"];
    
    range = 12;
    
    point = CGPointMake(start_point_x, 0);
    
    river_node.path_right = CGPathCreateMutable();
    river_node.path_left = CGPathCreateMutable();
    
    CGPathMoveToPoint(river_node.path_left, NULL, map_size/2, 0);
    CGPathMoveToPoint(river_node.path_right, NULL, (map_size/2 + tile_size * WIDTH_OF_RIVER), 0);
    
    while ((point.y < map_size) && (point.x < map_size) && (point.x > 0))
    {
        
        direction = [river_node calculateDirection:direction_old];
        
        if(direction == 1)
        {
            start = 3;
            range = 6;
        }
        else
        {
            start = 8;
            range = 15;
        }
        
        length = [river_node randomValuesForRiverLengthWithRange: range AndStart: start];
        
        //Call check method here
        [river_node checkRiverDirection:direction WithLength:&length MapSize:map_size Point:point TileSize:tile_size];
        
        if((map_size - point.y) <= (WIDTH_OF_RIVER * tile_size))
        {
            length = (map_size - point.y) / tile_size;
            
            if((direction_old == 2) || (direction_old == 1))
            {
              CGPathAddLineToPoint(river_node.path_left, NULL, point.x, (point.y + length));
              CGPathAddLineToPoint(river_node.path_right, NULL, (point.x + tile_size * WIDTH_OF_RIVER), (point.y + length));
            }
            else
            {
                CGPathAddLineToPoint(river_node.path_left, NULL, (point.x - tile_size * WIDTH_OF_RIVER), (point.y + length));
                CGPathAddLineToPoint(river_node.path_right, NULL, point.x, (point.y + length));
            }
        }
        
        if(direction == 1)
        {
            if(direction_old == 3)
            {
              point = [river_node verticalConstruct:point.x YValue:point.y Length:length Type:0 TileSize:tile_size Object:river_node];
              //Draw left form for left- direction
            }
            else
            {
              point = [river_node verticalConstruct:point.x YValue:point.y Length:length Type:1 TileSize:tile_size Object:river_node];
              //Draw right form for up and right- direction
            }
                
            calc_y = point.y;
        }
        else if(direction == 2)
        {
            point = [river_node horizontalConstruct:point.x YValue:point.y Length:length Type:1 TileSize:tile_size Object:river_node];
            calc_y = point.y;
        }
        else if (direction == 3)
        {
            point.x += tile_size * WIDTH_OF_RIVER;
            point = [river_node horizontalConstruct:point.x YValue:point.y Length:length Type:0 TileSize:tile_size Object:river_node];
            calc_y = point.y;

        }
        
        direction_old = direction;
    }
    
    
    river_node.shape_right = [SKShapeNode node];
    river_node.shape_right.path = river_node.path_right;
    river_node.shape_right.strokeColor = [SKColor brownColor];
    river_node.shape_right.lineWidth = 1.0;
    //river_node.shape_right.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:river_node.path_right];
    //river_node.shape_right.physicsBody.affectedByGravity = false;
    //river_node.shape_right.physicsBody.dynamic = false;
    [river_node.self addChild:river_node.shape_right];
    
    river_node.shape_left = [SKShapeNode node];
    river_node.shape_left.path = river_node.path_left;
    river_node.shape_left.strokeColor = [SKColor brownColor];
    river_node.shape_left.lineWidth = 1.0;
    //river_node.shape_left.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:river_node.path_left];
    //river_node.shape_left.physicsBody.affectedByGravity = false;
    //river_node.shape_left.physicsBody.dynamic = false;
    [river_node.self addChild:river_node.shape_left];
    
    return river_node;
    
}

-(void)checkRiverDirection: (int)direction WithLength: (int*)length MapSize: (int)map_size Point: (CGPoint)point TileSize: (int)tile_size
{
    if((direction == 2) && ((((*length) * tile_size) + point.x) > map_size))
    {
        *length = (map_size - point.x) / tile_size;
    }
    else if((direction == 1) && ((((*length) * tile_size) + point.y) > map_size))
    {
        *length = (map_size - point.y) / tile_size;
    }
    else if((direction == 3) && ((point.x - ((*length) * tile_size)) < 0))
    {
        *length = point.x / tile_size;
    }
}

-(int)randomValuesForRiverLengthWithRange: (int)range AndStart: (int)start
{
    int value;

    value = ((arc4random() % range) + start);
    
    return value;
}

-(int)calculateDirection: (int)direction_old
{
    //Calculate Direction: 1...up
    //                     2...right
    //                     3...left
    
    int diretion;
    
    if(direction_old == 2)
    {
        diretion = 1;
    }
    else if(direction_old == 3)
    {
        diretion = 1;
    }
    else if(direction_old == 1)
    {
        do
        {
          diretion = ((arc4random() % 3) + 1);
        }
        while(diretion == 1);
    }
    else
        diretion = 1;
    
    return diretion;
    
}

-(CGPoint)verticalConstruct: (int)start_point_x YValue: (int)start_point_y Length: (int)length Type: (int)type TileSize: (int)tile_size Object: (PODRiverNode*)river_node
{
    int x = start_point_x;
    int y = start_point_y;
    CGPoint last_point;
    
    for(int i = 0; i < length; i++)
    {
        x = start_point_x;
        
        for(int j = 0; j < WIDTH_OF_RIVER; j++)
        {
            SKSpriteNode *river_sprite = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"Water"]size:CGSizeMake(tile_size, tile_size)];
            
            
            if(type)
              [river_sprite setAnchorPoint:CGPointMake(0.0, 0.0)];
            else
              [river_sprite setAnchorPoint:CGPointMake(1.0, 0.0)];

            [river_sprite setPosition:CGPointMake(x, y)];
            [self addChild:river_sprite];
            
            if(type)
              x += tile_size;
            else
              x -= tile_size;
            
        }
        y += tile_size;
    }
    
    if(type)
      last_point = CGPointMake((x - tile_size*WIDTH_OF_RIVER), y);
    else
    {
      last_point = CGPointMake(x, y);
    }
    
    
    return last_point;
}

-(CGPoint)horizontalConstruct: (int)start_point_x YValue: (int)start_point_y Length: (int)length Type: (int)type TileSize: (int)tile_size Object: (PODRiverNode*)river_node
{
    int x = start_point_x;
    int y = start_point_y;
    CGPoint last_point;
    
    for(int i = 0; i < length; i++)
    {
        y = start_point_y;
        
        for(int j = 0; j < WIDTH_OF_RIVER; j++)
        {
            SKSpriteNode *river_sprite = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"Water"]size:CGSizeMake(tile_size, tile_size)];
            
            if(type)
              [river_sprite setAnchorPoint:CGPointMake(0.0, 0.0)];
            else
              [river_sprite setAnchorPoint:CGPointMake(1.0, 0.0)];
            
            [river_sprite setPosition:CGPointMake(x, y)];
            [self addChild:river_sprite];
            
            y += tile_size;
        }
        
        if(type)
          x += tile_size;
        else
          x -= tile_size;
    }
    
    if(type)
        last_point = CGPointMake(x - tile_size * WIDTH_OF_RIVER, y);
    else
    {
        last_point = CGPointMake(x + tile_size * WIDTH_OF_RIVER, y);
    }
    
    if(type)
    {
      CGPathAddLineToPoint(river_node.path_left, NULL, start_point_x, start_point_y);
      CGPathAddLineToPoint(river_node.path_left, NULL, start_point_x, last_point.y);
      CGPathAddLineToPoint(river_node.path_left, NULL, last_point.x, last_point.y);
      CGPathAddLineToPoint(river_node.path_right, NULL, (start_point_x + tile_size * WIDTH_OF_RIVER), start_point_y);
      CGPathAddLineToPoint(river_node.path_right, NULL, x, start_point_y);
      CGPathAddLineToPoint(river_node.path_right, NULL, x, last_point.y);
    }
    else
    {
        CGPathAddLineToPoint(river_node.path_left, NULL, (start_point_x - tile_size * WIDTH_OF_RIVER), start_point_y);
        CGPathAddLineToPoint(river_node.path_left, NULL, x, start_point_y);
        CGPathAddLineToPoint(river_node.path_left, NULL, x, last_point.y);
        CGPathAddLineToPoint(river_node.path_right, NULL, start_point_x, start_point_y);
        CGPathAddLineToPoint(river_node.path_right, NULL, start_point_x, last_point.y);
        CGPathAddLineToPoint(river_node.path_right, NULL, last_point.x, last_point.y);
    }
    
    
    return last_point;
    
}

@end