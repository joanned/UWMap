//
//  DataProvider.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/23/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "DataProvider.h"
#import "Building.h"
#import "Constants.h"

@implementation DataProvider

+ (NSDictionary *)buildingDictionary {
#warning change points to be percent values instead
    
    NSString *al = @"Arts Lecture Hall";
    NSString *b1 = @"Biology 1";
    NSString *b2 = @"Biology 2";
    NSString *bcm = @"B.C. Matthews Hall";
    NSString *c2 = @"Chemistry 2";

    
    Building *AL = [[Building alloc] initWithBuildingName:[NSString stringWithFormat:@"%@ AL", al] positionX:0.5f positionY:0.5f hours:@"8:00am - 10:00pm"];
    Building *B1 = [[Building alloc] initWithBuildingName:[NSString stringWithFormat:@"%@ B1", b1] positionX:0.6f positionY:0.6f hours:@"8:00am - 10:00pm"];
    Building *B2 = [[Building alloc] initWithBuildingName:[NSString stringWithFormat:@"%@ B2", b2] positionX:0.7f positionY:0.7f hours:@"8:00am - 10:00pm"];
    Building *BCM = [[Building alloc] initWithBuildingName:[NSString stringWithFormat:@"%@ BCM", bcm] positionX:2694/kMapImageWidth positionY:1112/kMapImageHeight hours:@"8:00am - 10:00pm"];
    Building *C2 = [[Building alloc] initWithBuildingName:[NSString stringWithFormat:@"%@ C2", c2] positionX:1859.0f/kMapImageWidth positionY:955/kMapImageHeight hours:@"8:00am - 10:00pm"];
    
    NSDictionary *buildingDictionary = @{
                                         al : AL,
                                        b1 : B1,
                                         b2 : B2,
                                          bcm : BCM,
                                         c2 : C2
                                         };
    
    return buildingDictionary;
}

@end
