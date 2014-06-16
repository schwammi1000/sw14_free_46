//
//  PODCollisionHandling.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 08.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODCollisionHandling.h"
#import "PODHero.h"

@implementation PODCollisionHandling

-(instancetype)initWithHero:(PODHero*)hero
{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    self.hero = hero;
    
    return self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    if(contact.bodyA.categoryBitMask == COIN)
    {
        [contact.bodyA.node.parent removeFromParent];
        [self.hero foundCoin];
    }
    else if(contact.bodyB.categoryBitMask == COIN)
    {
        [contact.bodyB.node.parent removeFromParent];
        [self.hero foundCoin];
    }
}

@end
