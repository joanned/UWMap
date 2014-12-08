//
//  DataProvider.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/26/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataProvider : NSObject

+ (NSMutableDictionary *)buildingDictionary;
+ (NSMutableDictionary *)foodDictionaryFromJson:(NSData *)data shortformArray:(NSArray *)shortformArray error:(NSError **)error;

@end
