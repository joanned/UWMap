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
    NSString *brh = @"Brubacher House";
    NSString *cgr = @"Conrad Grebel University College";
    NSString *cif = @"Columbia Icefield";
    NSString *cln = @"Columbia Lake Village North";
    NSString *clv = @"Columbia Lake Village";
    NSString *cog = @"Columbia Greenhouses";
    NSString *com = @"Commissary (UW Police)";
    NSString *cph = @"Carl A. Pollock Hall";
    NSString *csb = @"Central Services Building";
    NSString *dc = @"Davis Centre";
    NSString *dwe = @"Douglas Wright Engineering Building";

    
    Building *AL = [[Building alloc] initWithBuildingName:al
                                                shortform:@"AL"
                                                positionX:2696/kMapImageWidth
                                                positionY:2185/kMapImageHeight
                                                    hours:@"8:00am - 10:00pm"];
    
    Building *B1 = [[Building alloc] initWithBuildingName:b1
                                                shortform:@"B1"
                                                positionX:2705/kMapImageWidth
                                                positionY:1800/kMapImageHeight
                                                    hours:@"8:00am - 10:00pm"];
    
    Building *B2 = [[Building alloc] initWithBuildingName:b2
                                                shortform:@"B2"
                                                positionX:2615/kMapImageWidth
                                                positionY:1724/kMapImageHeight
                                                    hours:@"8:00am - 10:00pm"];
    
    Building *BCM = [[Building alloc] initWithBuildingName:bcm
                                                 shortform:@"BCM"
                                                 positionX:2694/kMapImageWidth
                                                 positionY:1122/kMapImageHeight
                                                     hours:@"8:00am - 10:00pm"];
    
    Building *C2 = [[Building alloc] initWithBuildingName:c2
                                                shortform:@"C2"
                                                positionX:2829/kMapImageWidth
                                                positionY:1539/kMapImageHeight
                                                    hours:@"8:00am - 10:00pm"];
    
    Building *BRH = [[Building alloc] initWithBuildingName:brh
                                                 shortform:@"BRH"
                                                positionX:1940/kMapImageWidth
                                                positionY:431/kMapImageHeight
                                                    hours:@""];
    
    Building *CGR = [[Building alloc] initWithBuildingName:cgr
                                                 shortform:@"CGR"
                                                 positionX:2099/kMapImageWidth
                                                 positionY:2367/kMapImageHeight
                                                     hours:@""];
    
    Building *CIF = [[Building alloc] initWithBuildingName:cif
                                                 shortform:@"CIF"
                                                 positionX:2410/kMapImageWidth
                                                 positionY:685/kMapImageHeight
                                                     hours:@""];
    
    Building *CLN = [[Building alloc] initWithBuildingName:cln
                                                 shortform:@"CLN"
                                                 positionX:342/kMapImageWidth
                                                 positionY:371/kMapImageHeight
                                                     hours:@""];
    
    Building *CLV = [[Building alloc] initWithBuildingName:clv
                                                 shortform:@"CLV"
                                                 positionX:356/kMapImageWidth
                                                 positionY:746/kMapImageHeight
                                                     hours:@""];
    
    Building *COG = [[Building alloc] initWithBuildingName:cog
                                                 shortform:@"COG"
                                                 positionX:836/kMapImageWidth
                                                 positionY:366/kMapImageHeight
                                                     hours:@""];
    
    Building *COM = [[Building alloc] initWithBuildingName:com
                                                 shortform:@"COM"
                                                 positionX:2992/kMapImageWidth
                                                 positionY:1236/kMapImageHeight
                                                     hours:@""];
    
    Building *CPH = [[Building alloc] initWithBuildingName:cph
                                                 shortform:@"CPH"
                                                 positionX:3165/kMapImageWidth
                                                 positionY:1986/kMapImageHeight
                                                     hours:@""];
    
    Building *CSB = [[Building alloc] initWithBuildingName:csb
                                                 shortform:@"CSB"
                                                 positionX:2868/kMapImageWidth
                                                 positionY:1202/kMapImageHeight
                                                     hours:@""];
    
    Building *DC = [[Building alloc] initWithBuildingName:csb
                                                 shortform:@"DC William G. Davis Computer Research Centre"
                                                 positionX:2960/kMapImageWidth
                                                 positionY:1501/kMapImageHeight
                                                     hours:@""];
    
    Building *DWE = [[Building alloc] initWithBuildingName:dwe
                                                shortform:@"DWE"
                                                positionX:3007/kMapImageWidth
                                                positionY:2064/kMapImageHeight
                                                    hours:@""];
    
    NSDictionary *buildingDictionary = @{
                                         al : AL,
                                         b1 : B1,
                                         b2 : B2,
                                         bcm : BCM,
                                         brh : BRH,
                                         c2 : C2,
                                         cgr : CGR,
                                         cif : CIF,
                                         cln : CLN,
                                         clv : CLV,
                                         cog : COG,
                                         com : COM,
                                         cph : CPH,
                                         csb : CSB,
                                         dc : DC,
                                         dwe : DWE
                                         };
    
    return buildingDictionary;
}

@end
