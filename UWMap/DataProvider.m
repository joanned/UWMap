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
#import "FoodData.h"
#import "NSString+HTML.h"

@implementation DataProvider

+ (NSMutableDictionary *)buildingDictionary {
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
    NSString *v1 = @"Village 1";
    NSString *wcp = @"Waterloo Central Place";
    
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
    
    Building *DC = [[Building alloc] initWithBuildingName:dc
                                                 shortform:@"DC"
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
                                                 positionX:2579.000000/kMapImageWidth
                                                 positionY:2217.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *EV2 = [[Building alloc] initWithBuildingName:ev2
                                                 shortform:@"EV2"
                                                 positionX:2505.000000/kMapImageWidth
                                                 positionY:2225.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *EV3 = [[Building alloc] initWithBuildingName:ev3
                                                 shortform:@"EV3"
                                                 positionX:2451.000000/kMapImageWidth
                                                 positionY:2159.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *ESC = [[Building alloc] initWithBuildingName:esc
                                                 shortform:@"ESC"
                                                 positionX:2791.000000/kMapImageWidth
                                                 positionY:1693.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *FED = [[Building alloc] initWithBuildingName:fed
                                                 shortform:@"FED"
                                                 positionX:2190.000000/kMapImageWidth
                                                 positionY:993.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *GH = [[Building alloc] initWithBuildingName:gh
                                                 shortform:@"GH"
                                                 positionX:2864.000000/kMapImageWidth
                                                 positionY:2033.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *GSC = [[Building alloc] initWithBuildingName:gsc
                                                 shortform:@"GSC"
                                                 positionX:2917.000000/kMapImageWidth
                                                 positionY:1297.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *HH = [[Building alloc] initWithBuildingName:hh
                                                 shortform:@"HH"
                                                 positionX:2649.000000/kMapImageWidth
                                                 positionY:2331.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *HMN = [[Building alloc] initWithBuildingName:hmn
                                                 shortform:@"HMN"
                                                 positionX:2449.000000/kMapImageWidth
                                                 positionY:431.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *HS = [[Building alloc] initWithBuildingName:hs
                                                 shortform:@"HS"
                                                 positionX:2280.000000/kMapImageWidth
                                                 positionY:1575.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *KDC = [[Building alloc] initWithBuildingName:kdc
                                                 shortform:@"KDC"
                                                 positionX:2436.000000/kMapImageWidth
                                                 positionY:551.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *LHI = [[Building alloc] initWithBuildingName:lhi
                                                 shortform:@"LHI"
                                                 positionX:2560.000000/kMapImageWidth
                                                 positionY:1176.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *DP = [[Building alloc] initWithBuildingName:dp
                                                 shortform:@"DP"
                                                 positionX:2709.000000/kMapImageWidth
                                                 positionY:1957.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *M3 = [[Building alloc] initWithBuildingName:m3
                                                 shortform:@"M3"
                                                 positionX:2758.000000/kMapImageWidth
                                                 positionY:1319.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *MC = [[Building alloc] initWithBuildingName:mc
                                                 shortform:@"MC"
                                                 positionX:2708.000000/kMapImageWidth
                                                 positionY:1502.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *MHR = [[Building alloc] initWithBuildingName:mhr
                                                 shortform:@"MHR"
                                                 positionX:2344.000000/kMapImageWidth
                                                 positionY:2593.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *MKV = [[Building alloc] initWithBuildingName:mkv
                                                 shortform:@"MKV"
                                                 positionX:1574.000000/kMapImageWidth
                                                 positionY:1130.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *ML = [[Building alloc] initWithBuildingName:ml
                                                 shortform:@"ML"
                                                 positionX:2612.000000/kMapImageWidth
                                                 positionY:2032.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *NH = [[Building alloc] initWithBuildingName:nh
                                                 shortform:@"NH"
                                                 positionX:2529.000000/kMapImageWidth
                                                 positionY:1941.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *OPT = [[Building alloc] initWithBuildingName:opt
                                                 shortform:@"OPT"
                                                 positionX:2811.000000/kMapImageWidth
                                                 positionY:742.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *PAC = [[Building alloc] initWithBuildingName:pac
                                                 shortform:@"PAC"
                                                 positionX:2438.000000/kMapImageWidth
                                                 positionY:1313.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *PAS = [[Building alloc] initWithBuildingName:pas
                                                 shortform:@"PAS"
                                                 positionX:2469.000000/kMapImageWidth
                                                 positionY:2435.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *PHY = [[Building alloc] initWithBuildingName:phy
                                                 shortform:@"PHY"
                                                 positionX:2871.000000/kMapImageWidth
                                                 positionY:1860.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *QNC = [[Building alloc] initWithBuildingName:qnc
                                                 shortform:@"QNC"
                                                 positionX:2605.000000/kMapImageWidth
                                                 positionY:1639.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *RCH = [[Building alloc] initWithBuildingName:rch
                                                 shortform:@"RCH"
                                                 positionX:2948.000000/kMapImageWidth
                                                 positionY:1982.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *REN = [[Building alloc] initWithBuildingName:ren
                                                 shortform:@"REN"
                                                 positionX:2004.000000/kMapImageWidth
                                                 positionY:1789.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *REV = [[Building alloc] initWithBuildingName:rev
                                                 shortform:@"REV"
                                                 positionX:1281.000000/kMapImageWidth
                                                 positionY:1239.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *SCH = [[Building alloc] initWithBuildingName:sch
                                                 shortform:@"SCH"
                                                 positionX:2875.000000/kMapImageWidth
                                                 positionY:2146.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *SLC = [[Building alloc] initWithBuildingName:slc
                                                 shortform:@"SLC"
                                                 positionX:2502.000000/kMapImageWidth
                                                 positionY:1484.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *STJ = [[Building alloc] initWithBuildingName:stj
                                                 shortform:@"STJ"
                                                 positionX:2217.000000/kMapImageWidth
                                                 positionY:1814.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *STP = [[Building alloc] initWithBuildingName:stp
                                                 shortform:@"STP"
                                                 positionX:2016.000000/kMapImageWidth
                                                 positionY:2118.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *TC = [[Building alloc] initWithBuildingName:tc
                                                 shortform:@"TC"
                                                 positionX:2788.000000/kMapImageWidth
                                                 positionY:2104.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *TH = [[Building alloc] initWithBuildingName:th
                                                 shortform:@"TH"
                                                 positionX:1536.000000/kMapImageWidth
                                                 positionY:1266.000000/kMapImageHeight
                                                     hours:@""];
    
    Building *WCP = [[Building alloc] initWithBuildingName:wcp
                                                shortform:@"WCP"
                                                positionX:4205.000000/kMapImageWidth
                                                positionY:2119.000000/kMapImageHeight
                                                    hours:@""];
    
    Building *UC = [[Building alloc] initWithBuildingName:uc
                                                 shortform:@"UC"
                                                 positionX:2321.000000/kMapImageWidth
                                                 positionY:1217.000000/kMapImageHeight
                                                     hours:@""];
    
    
    Building *UWP = [[Building alloc] initWithBuildingName:uwp
                                                shortform:@"UWP"
                                                positionX:3662.000000/kMapImageWidth
                                                positionY:2197.000000/kMapImageHeight
                                                    hours:@""];
    
    Building *V1 = [[Building alloc] initWithBuildingName:v1
                                                shortform:@"V1"
                                                positionX:1923.000000/kMapImageWidth
                                                positionY:1213.000000/kMapImageHeight
                                                    hours:@""];
 
    NSMutableDictionary *buildingDictionary = [[NSMutableDictionary alloc] init];
    [buildingDictionary setValue:AL forKey:al];
    [buildingDictionary setValue:B1 forKey:b1];
    [buildingDictionary setValue:B2 forKey:b2];
    [buildingDictionary setValue:BCM forKey:bcm];
    [buildingDictionary setValue:BRH forKey:brh];
    [buildingDictionary setValue:C2 forKey:c2];
    [buildingDictionary setValue:CGR forKey:cgr];
    [buildingDictionary setValue:CIF forKey:cif];
    [buildingDictionary setValue:CLN forKey:cln];
    [buildingDictionary setValue:CLV forKey:clv];
    [buildingDictionary setValue:COG forKey:cog];
    [buildingDictionary setValue:COM forKey:com];
    [buildingDictionary setValue:CPH forKey:cph];
    [buildingDictionary setValue:CSB forKey:csb];
    [buildingDictionary setValue:DC forKey:dc];
    [buildingDictionary setValue:DWE forKey:dwe];
    [buildingDictionary setValue:E2 forKey:e2];
    [buildingDictionary setValue:E3 forKey:e3];
    [buildingDictionary setValue:E5 forKey:e5];
    [buildingDictionary setValue:E6 forKey:e6];
    [buildingDictionary setValue:EC1 forKey:ec1];
    [buildingDictionary setValue:EC2 forKey:ec2];
    [buildingDictionary setValue:EC3 forKey:ec3];
    [buildingDictionary setValue:ECH forKey:ech];
    [buildingDictionary setValue:EIT forKey:eit];
    [buildingDictionary setValue:ERC forKey:erc];
    [buildingDictionary setValue:EV1 forKey:ev1];
    [buildingDictionary setValue:EV2 forKey:ev2];
    [buildingDictionary setValue:EV3 forKey:ev3];
    [buildingDictionary setValue:ESC forKey:esc];
    [buildingDictionary setValue:FED forKey:fed];
    [buildingDictionary setValue:GH forKey:gh];
    [buildingDictionary setValue:GSC forKey:gsc];
    [buildingDictionary setValue:HH forKey:hh];
    [buildingDictionary setValue:HMN forKey:hmn];
    [buildingDictionary setValue:HS forKey:hs];
    [buildingDictionary setValue:KDC forKey:kdc];
    [buildingDictionary setValue:LHI forKey:lhi];
    [buildingDictionary setValue:DP forKey:dp];
    [buildingDictionary setValue:M3 forKey:m3];
    [buildingDictionary setValue:MC forKey:mc];
    [buildingDictionary setValue:MHR forKey:mhr];
    [buildingDictionary setValue:MKV forKey:mkv];
    [buildingDictionary setValue:ML forKey:ml];
    [buildingDictionary setValue:NH forKey:nh];
    [buildingDictionary setValue:OPT forKey:opt];
    [buildingDictionary setValue:PAC forKey:pac];
    [buildingDictionary setValue:PAS forKey:pas];
    [buildingDictionary setValue:PHY forKey:phy];
    [buildingDictionary setValue:QNC forKey:qnc];
    [buildingDictionary setValue:RCH forKey:rch];
    [buildingDictionary setValue:REN forKey:ren];
    [buildingDictionary setValue:REV forKey:rev];
    [buildingDictionary setValue:SCH forKey:sch];
    [buildingDictionary setValue:SLC forKey:slc];
    [buildingDictionary setValue:STJ forKey:stj];
    [buildingDictionary setValue:STP forKey:stp];
    [buildingDictionary setValue:TC forKey:tc];
    [buildingDictionary setValue:TH forKey:th];
    [buildingDictionary setValue:UC forKey:uc];
    [buildingDictionary setValue:WCP forKey:wcp];
    [buildingDictionary setValue:UWP forKey:uwp];
    [buildingDictionary setValue:V1 forKey:v1];
    
    return buildingDictionary;
}

//todo: move this elsewhere
+ (NSMutableDictionary *)foodDictionaryFromJson:(NSData *)data shortformArray:(NSArray *)shortformArray error:(NSError **)error {
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableDictionary *foodDataDictionary = [[NSMutableDictionary alloc] init];
    NSDictionary *foodsDictionary = [parsedObject valueForKey:@"data"];
    
    for (NSDictionary *foodDictionary in foodsDictionary) {
        FoodData *foodData = [[FoodData alloc] init];
        
        //don't include this location if it's not on our map
        NSString *building = [foodDictionary valueForKey:@"building"];
        if (![shortformArray containsObject:building]) {
            continue;
        }
        [foodData setBuilding:building];
        
        NSString *adjustedString =  [[foodDictionary valueForKey:@"outlet_name"] stringByReplacingOccurrencesOfString:@"U" withString:@"u"];//TODO:must change this later..
        
        [foodData setTitle:adjustedString];

        if ([[foodDictionary valueForKey:@"logo"] isKindOfClass:[NSNull class]]) {
            [foodData setImageUrl:nil];
        } else {
            [foodData setImageUrl:[foodDictionary valueForKey:@"logo"]];
        }
        
        if ([[foodDictionary valueForKey:@"description"] isKindOfClass:[NSNull class]]) {
            [foodData setFoodDescription:nil];
        } else {
            NSString *foodDescription = [foodDictionary valueForKey:@"description"];
            foodDescription = [foodDescription stringByDecodingHTMLEntities];
            [foodData setFoodDescription:foodDescription];
        }
        
        if ([[foodDictionary valueForKey:@"is_open_now"] isKindOfClass:[NSNull class]]) {
            [foodData setIsOpenNow:nil];
        } else {
            [foodData setIsOpenNow:[foodDictionary valueForKey:@"is_open_now"]];
        }
        
        NSDictionary *hoursDictionary = [foodDictionary valueForKey:@"opening_hours"];
        
        NSDictionary *mondayHours = [hoursDictionary valueForKey:@"monday"];
        
        if ([[mondayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setMondayOpen:nil];
        } else {
            [foodData setMondayOpen:[mondayHours valueForKey:@"opening_hour"]];
        }
        
        if ([[mondayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setMondayClose:nil];
        } else {
            [foodData setMondayClose:[mondayHours valueForKey:@"closing_hour"]];
        }
        
        NSDictionary *tuesdayHours = [hoursDictionary valueForKey:@"tuesday"];

        if ([[tuesdayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setTuesdayOpen:nil];
        } else {
            [foodData setTuesdayOpen:[tuesdayHours valueForKey:@"opening_hour"]];
        }
        
        if ([[tuesdayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setTuesdayClose:nil];
        } else {
            [foodData setTuesdayClose:[tuesdayHours valueForKey:@"closing_hour"]];
        }
    
        NSDictionary *wednesdayHours = [hoursDictionary valueForKey:@"wednesday"];
        
        if ([[wednesdayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setWednesdayOpen:nil];
        } else {
            [foodData setWednesdayOpen:[wednesdayHours valueForKey:@"opening_hour"]];
        }
    
        if ([[wednesdayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setWednesdayClose:nil];
        } else {
            [foodData setWednesdayClose:[wednesdayHours valueForKey:@"closing_hour"]];
        }
    
        NSDictionary *thursdayHours = [hoursDictionary valueForKey:@"thursday"];

        if ([[thursdayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setThursdayOpen:nil];
        } else {
            [foodData setThursdayOpen:[thursdayHours valueForKey:@"opening_hour"]];
        }
        
        if ([[thursdayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setThursdayClose:nil];
        } else {
            [foodData setThursdayClose:[thursdayHours valueForKey:@"closing_hour"]];
        }
        
        NSDictionary *fridayHours = [hoursDictionary valueForKey:@"friday"];
        
        if ([[fridayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setFridayOpen:nil];
        } else {
            [foodData setFridayOpen:[fridayHours valueForKey:@"opening_hour"]];
        }
        
        if ([[fridayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setFridayClose:nil];
        } else {
            [foodData setFridayClose:[fridayHours valueForKey:@"closing_hour"]];
        }
        
        NSDictionary *saturdayHours = [hoursDictionary valueForKey:@"saturday"];
        
        if ([[saturdayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setSaturdayOpen:nil];
        } else {
            [foodData setSaturdayOpen:[saturdayHours valueForKey:@"opening_hour"]];
        }
        
        if ([[saturdayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setSaturdayClose:nil];
        } else {
            [foodData setSaturdayClose:[saturdayHours valueForKey:@"closing_hour"]];
        }
                                    
        NSDictionary *sundayHours = [hoursDictionary valueForKey:@"sunday"];
        
        if ([[sundayHours valueForKey:@"opening_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setSundayOpen:nil];
        } else {
            [foodData setSundayOpen:[sundayHours valueForKey:@"opening_hour"]];
        }
        
        if ([[sundayHours valueForKey:@"closing_hour"] isKindOfClass:[NSNull class]]) {
            [foodData setSundayClose:nil];
        } else {
            [foodData setSundayClose:[sundayHours valueForKey:@"closing_hour"]];
        }
        
        [foodDataDictionary setValue:foodData forKey:foodData.title];
    }
    return foodDataDictionary;
}


@end
