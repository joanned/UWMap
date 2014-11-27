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
    NSString *e2 = @"Engineering 2";
    NSString *e3 = @"Engineering 3";
    NSString *e5 = @"Engineering 5";
    NSString *e6 = @"Engineering 6";
    NSString *ec1 = @"East Campus 1";
    NSString *ec2 = @"East Campus 2";
    NSString *ec3 = @"East Campus 3";
    NSString *ech = @"East Campus Hall";
    NSString *eit = @"Centre for Environmental and Information Technology";
    NSString *erc = @"Energy Research Centre";
    NSString *ev1 = @"Environment 1";
    NSString *ev2 = @"Environment 2";
    NSString *ev3 = @"Environment 3";
    NSString *esc = @"Earth Sciences and Chemistry";
    NSString *fed = @"Federation Hall";
    NSString *gh = @"Graduate House";
    NSString *gsc = @"General Services Complex";
    NSString *hh = @"J.G. Hagey Hall";
    NSString *hmn = @"Hildegard Marsden Nursery";
    NSString *hs = @"Health Services";
    NSString *kdc = @"Klemmer Day Care";
    NSString *lhi = @"Lyle S. Hallman Institute for Health Promotion";
    NSString *dp = @"Dana Porter Library";
    NSString *m3 = @"Mathematics 3";
    NSString *mc = @"Mathematics and Computer Building";
    NSString *mhr = @"Minota Hagey Residence";
    NSString *mkv = @"William Lyon Mackenzie King Village";
    NSString *ml = @"Modern Languages";
    NSString *nh = @"Ira G. Needles Hall";
    NSString *opt = @"Optometry Building";
    NSString *pac = @"Physical Activities Complex";
    NSString *pas = @"Psychology, Anthropology, Sociology";
    NSString *phy = @"Physics";
    NSString *qnc = @"Quantum-Nano Centre";
    NSString *ra2 = @"Research Advancement Centre 2";
    NSString *rac = @"Research Advancement Centre";
    NSString *rch = @"J.R. Coutts Engineering Lecture Hall";
    NSString *ren = @"Renison University College";
    NSString *rev = @"Ron Eydt Village";
    NSString *sch = @"South Campus Hall";
    NSString *slc = @"Student Life Centre";
    NSString *stj = @"St. Jerome's University";
    NSString *stp = @"St. Paul's University College";
    NSString *tc = @"William M. Tatham Centre";
    NSString *th = @"Tutors' Houses";
    NSString *uc = @"University Club";
    NSString *uwp = @"University of Waterloo Place";
    NSString *v1 = @"Student Village";
    
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
    
    Building *E2 = [[Building alloc] initWithBuildingName:e2
                                                 shortform:@"E2"
                                                 positionX:3058/kMapImageWidth
                                                 positionY:1936/kMapImageHeight
                                                     hours:@""];
    
    Building *E3 = [[Building alloc] initWithBuildingName:e3
                                                shortform:@"E3"
                                                positionX:3057/kMapImageWidth
                                                positionY:1770/kMapImageHeight
                                                    hours:@""];
    
    Building *E5 = [[Building alloc] initWithBuildingName:e5
                                                shortform:@"E5"
                                                positionX:3247/kMapImageWidth
                                                positionY:1626/kMapImageHeight
                                                    hours:@""];
    
    Building *E6 = [[Building alloc] initWithBuildingName:e6
                                                shortform:@"E6"
                                                positionX:3423/kMapImageWidth
                                                positionY:1676/kMapImageHeight
                                                    hours:@""];
    
    Building *EC1 = [[Building alloc] initWithBuildingName:ec1
                                                shortform:@"EC1"
                                                positionX:3482/kMapImageWidth
                                                positionY:1031/kMapImageHeight
                                                    hours:@""];
    
    Building *EC2 = [[Building alloc] initWithBuildingName:ec2
                                                 shortform:@"EC2"
                                                 positionX:3198/kMapImageWidth
                                                 positionY:1241/kMapImageHeight
                                                     hours:@""];
    
    Building *EC3 = [[Building alloc] initWithBuildingName:ec3
                                                 shortform:@"EC3"
                                                 positionX:3215.000000/kMapImageWidth
                                                 positionY:1008.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *ECH = [[Building alloc] initWithBuildingName:ech
                                                 shortform:@"ECH"
                                                 positionX:3492.000000/kMapImageWidth
                                                 positionY:1540.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *EIT = [[Building alloc] initWithBuildingName:eit
                                                 shortform:@"EIT"
                                                 positionX:2896.000000/kMapImageWidth
                                                 positionY:1712.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *ERC = [[Building alloc] initWithBuildingName:erc
                                                 shortform:@"ERC"
                                                 positionX:2741.000000/kMapImageWidth
                                                 positionY:1233.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *EV1 = [[Building alloc] initWithBuildingName:ev1
                                                 shortform:@"EV1"
                                                 positionX:2896.000000/kMapImageWidth
                                                 positionY:1712.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *EV2 = [[Building alloc] initWithBuildingName:ev2
                                                 shortform:@"EV2"
                                                 positionX:2896.000000/kMapImageWidth
                                                 positionY:1712.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *EV3 = [[Building alloc] initWithBuildingName:ev3
                                                 shortform:@"EV3"
                                                 positionX:2896.000000/kMapImageWidth
                                                 positionY:1712.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *ESC = [[Building alloc] initWithBuildingName:esc
                                                 shortform:@"ESC"
                                                 positionX:2896.000000/kMapImageWidth
                                                 positionY:1712.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *FED = [[Building alloc] initWithBuildingName:fed
                                                 shortform:@"FED"
                                                 positionX:2896.000000/kMapImageWidth
                                                 positionY:1712.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *EIT = [[Building alloc] initWithBuildingName:eit
                                                 shortform:@"EIT"
                                                 positionX:2896.000000/kMapImageWidth
                                                 positionY:1712.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *EIT = [[Building alloc] initWithBuildingName:eit
                                                 shortform:@"EIT"
                                                 positionX:2896.000000/kMapImageWidth
                                                 positionY:1712.000000/kMapImageHeight
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
                                         dwe : DWE,
                                         e2 : E2,
                                         e3 : E3,
                                         e5 : E5,
                                         e6 : E6,
                                         ec1 : EC1,
                                         ec2 : EC2,
                                         ec3 : EC3,
                                         ech : ECH,
                                         eit : EIT,
                                         erc : ERC,
                                         ev1 : EV1,
                                         ev2 : EV2,
                                         ev3 : EV3,
                                         esc : ESC,
                                         fed : FED,
                                         gh : GH,
                                         gsc : GSC,
                                         hh : HH,
                                         hmn : HMN,
                                         hs : HS,
                                         kdc : KDC,
                                         lhi : LHI,
                                         dp : DP,
                                         m3 : M3,
                                         mc : MC,
                                         mhr : MHR,
                                         mkv : MKV,
                                         ml : ML,
                                         nh : NH,
                                         opt : OPT,
                                         pac : PAC,
                                         pas : PAS,
                                         phy : PHY,
                                         qnc : QNC,
                                         ra2 : RA2,
                                         rac : RAC,
                                         rch : RCH,
                                         ren : REN,
                                         rev : REV,
                                         sch : SCH,
                                         slc : SLC,
                                         stj : STJ,
                                         stp : STP,
                                         tc : TC,
                                         th : TH,
                                         uc : UC,
                                         uwp : UWP,
                                         v1 : V1
                                         };
    
    return buildingDictionary;
}

@end
