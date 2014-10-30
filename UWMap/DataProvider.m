//
//  DataProvider.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/23/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "DataProvider.h"
#import "Building.h"

@implementation DataProvider

+ (NSDictionary *)buildingDictionary {
#warning change points to be percent values instead
    
    Building *AL = [[Building alloc] initWithpositionX:0.5f positionY:0.5f hours:@"8:00am - 10:00pm"];
    Building *B1 = [[Building alloc] initWithpositionX:0.6f positionY:0.6f hours:@"8:00am - 10:00pm"];
    Building *B2 = [[Building alloc] initWithpositionX:0.7f positionY:0.7f hours:@"8:00am - 10:00pm"];
    Building *BCM = [[Building alloc] initWithpositionX:0.8f positionY:0.8f hours:@"8:00am - 10:00pm"];
    
    NSDictionary *buildingDictionary = @{
                                         @"Arts Lecture Hall" : AL,
                                         @"Biology 1" : B1,
                                         @"Biology 2" : B2,
                                         @"B.C. Matthews Hall" : BCM,
                                         };
    
    return buildingDictionary;
}

@end
