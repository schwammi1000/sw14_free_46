//
//  PODCollisionHandling.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 08.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODCollisionHandling.h"

@implementation PODCollisionHandling

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"Contact Begin");
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    NSLog(@"Contact End");
}

@end
