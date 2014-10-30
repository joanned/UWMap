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
    Building *AL = [[Building alloc] initWithlocationPoint:[NSValue valueWithCGPoint:CGPointMake(793, 694)]
                                              locationRect:[NSValue valueWithCGRect:CGRectMake(793, 694, 16, 16)]
                                                     hours:@"8:00am - 10:00pm"];
    
    Building *B1 = [[Building alloc] initWithlocationPoint:[NSValue valueWithCGPoint:CGPointMake(793, 529)]
                                              locationRect:[NSValue valueWithCGRect:CGRectMake(793, 529, 16, 16)]
                                                     hours:@"8:00am - 10:00pm"];
    
    Building *B2 = [[Building alloc] initWithlocationPoint:[NSValue valueWithCGPoint:CGPointMake(757, 500)]
                                              locationRect:[NSValue valueWithCGRect:CGRectMake(757, 500, 16, 16)]
                                                     hours:@"8:00am - 10:00pm"];
    
    Building *BCM = [[Building alloc] initWithlocationPoint:[NSValue valueWithCGPoint:CGPointMake(789, 251)]
                                               locationRect:[NSValue valueWithCGRect:CGRectMake(789, 251, 16, 16)]
                                                      hours:@"8:00am - 10:00pm"];
    
    NSDictionary *buildingDictionary = @{
                                         @"Arts Lecture Hall" : AL,
                                         @"Biology 1" : B1,
                                         @"Biology 2" : B2,
                                         @"B.C. Matthews Hall" : BCM,
                                         };
    
    return buildingDictionary;
}

@end
