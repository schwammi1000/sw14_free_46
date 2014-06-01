//
//  PODUtility.m
//  ThePathOfTheDragon
//
//  Created by Markus Kammerhofer on 01.06.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "PODUtility.h"

@implementation PODUtility

+(int)createRandom
{
    bool useRandom = false;
    
    if(useRandom)
        return rand();
    else
        return 7;
}

@end
