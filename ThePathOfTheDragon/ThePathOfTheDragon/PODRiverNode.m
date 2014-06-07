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
    CGPoint point;
    
    
    
    PODRiverNode *river_node = [[PODRiverNode alloc] init];
    
    if(!river_node)
        return nil;

    start_point_x = map_size/2; //256;
    
    //Create atlas
    river_node.atlas = [SKTextureAtlas atlasNamed:@"Background"];
    
    range = 10;
    
    point = CGPointMake(start_point_x, 0);
    
    //printf("********** START FUNCTION *********\n");
    
    while ((point.y < map_size) && (point.x < map_size) && (point.x > 0))
    {
        direction = [river_node calculateDirection:direction_old];
        length = [river_node randomValuesForRiverLengthWithRange: range];
        
        //Call check method here
        [river_node checkRiverDirection:direction WithLength:&length MapSize:map_size Point:point TileSize:tile_size];
        
        
        if(direction == 1)
        {
            if(direction_old == 3)
            {
              point = [river_node verticalConstruct:point.x YValue:point.y Length:length Type:0 TileSize:tile_size];
              //Draw left form for left- direction
            }
            else
            {
              point = [river_node verticalConstruct:point.x YValue:point.y Length:length Type:1 TileSize:tile_size];
              //Draw right form for up and right- direction
            }
                
            calc_y = point.y;
            //printf("****UP****: %d\n", length);
        }
        else if(direction == 2)
        {
            point = [river_node horizontalConstruct:point.x YValue:point.y Length:length Type:1 TileSize:tile_size];
            calc_y = point.y;
            //printf("****RIGHT****: %d\n", length);
        }
        else if (direction == 3)
        {
            point.x += tile_size * WIDTH_OF_RIVER;
            point = [river_node horizontalConstruct:point.x YValue:point.y Length:length Type:0 TileSize:tile_size];
            calc_y = point.y;
            //printf("****LEFT****\n");
        }
        
        direction_old = direction;
    }
    
    
   // printf("****CALC****:\n X= %f ... Y= %f\n",point.x, point.y);
    //printf("MapSize: %d\n", map_size);
    
    //Just for testing river
    /*
    printf("++++CGPoint: %f ... %f\n", point.x, point.y);
    point = [river_node horizontalConstruct:point.x YValue:point.y Length:3 Type:1];
    printf("++++CGPoint: %f ... %f\n", point.x, point.y);
    point = [river_node horizontalConstruct:point.x YValue:point.y Length:3 Type:1];
    printf("++++CGPoint: %f ... %f\n", point.x, point.y);
    point = [river_node horizontalConstruct:point.x YValue:point.y Length:3 Type:1];
    printf("++++CGPoint: %f ... %f\n", point.x, point.y);
    
    point = [river_node verticalConstruct:point.x YValue:point.y Length:10 Type:1];
    printf("++++CGPoint: %f ... %f\n", point.x, point.y);
    point = [river_node horizontalConstruct:point.x YValue:point.y Length:3 Type:1];
    printf("++++CGPoint: %f ... %f\n", point.x, point.y);
    point = [river_node verticalConstruct:point.x YValue:point.y Length:10 Type:1];
    printf("++++CGPoint: %f ... %f\n", point.x, point.y);
    */
    return river_node;
    
}

-(void)checkRiverDirection: (int)direction WithLength: (int*)length MapSize: (int)map_size Point: (CGPoint)point TileSize: (int)tile_size
{
    if((direction == 2) && ((((*length) * tile_size) + point.x) > map_size))
    {
        *length = (map_size - point.x) / tile_size;
        //printf("Map to small: X\n Point.x= %f ... length= %d ... mapsize= %d\n\n", point.x, *length, map_size);
    }
    else if((direction == 1) && ((((*length) * tile_size) + point.y) > map_size))
    {
        *length = (map_size - point.y) / tile_size;
        //printf("Map to small: Y\n Point.y= %f ... length= %d ... mapsize= %d\n\n", point.y, *length, map_size);
    }
    else if((direction == 3) && ((point.x - ((*length) * tile_size)) < 0))
    {
        *length = point.x / tile_size;
        //printf("Map to small->0: X\n Point.y= %f ... length= %d ... mapsize= %d\n\n", point.y, *length, map_size);
    }
}

-(int)randomValuesForRiverLengthWithRange: (int)range
{
    int value;

    value = ((arc4random() % range) + 3);
    
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
        do
        {
            diretion = ((arc4random() % 3) + 1);
        }
        while(diretion == 3);
    }
    else if(direction_old == 3)
    {
        do
        {
            diretion = ((arc4random() % 3) + 1);
        }
        while(diretion == 2);
    }
    else
    {
        diretion = ((arc4random() % 3) + 1);
    }
    
    return diretion;
    
}

-(CGPoint)verticalConstruct: (int)start_point_x YValue: (int)start_point_y Length: (int)length Type: (int)type TileSize: (int)tile_size
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
            //river_sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:river_sprite.size];
            
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
            
            if((j == 0) || (j == (WIDTH_OF_RIVER - 1)))
            {
                //river_sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:river_sprite.size];
            }
        }
        y += tile_size;
    }
    
    if(type)
      last_point = CGPointMake((x - tile_size*WIDTH_OF_RIVER), y);
    else
    {
      last_point = CGPointMake(x, y);
      //printf("----- LastPoint: %f ... %f\n", last_point.x, last_point.y);
    }
    
    
    return last_point;
}

-(CGPoint)horizontalConstruct: (int)start_point_x YValue: (int)start_point_y Length: (int)length Type: (int)type TileSize: (int)tile_size
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
            //river_sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:river_sprite.size];
            
            if(type)
              [river_sprite setAnchorPoint:CGPointMake(0.0, 0.0)];
            else
              [river_sprite setAnchorPoint:CGPointMake(1.0, 0.0)];
            
            [river_sprite setPosition:CGPointMake(x, y)];
            [self addChild:river_sprite];
            
            y += tile_size;
            if((j == 0) || (j == (WIDTH_OF_RIVER - 1)))
            {
                //river_sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:river_sprite.size];
            }
        }
        
        if(type)
          x += tile_size;
        else
          x -= tile_size;
    }
    
    if(type)
      last_point = CGPointMake(x, (y - tile_size * WIDTH_OF_RIVER));
    else
    {
        last_point = CGPointMake(x, (y - tile_size * WIDTH_OF_RIVER));
        //printf("----- LastPoint: %f ... %f\n", last_point.x, last_point.y);
    }

    return last_point;
    
}

@end