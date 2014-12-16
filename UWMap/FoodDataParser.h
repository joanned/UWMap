//
//  FoodDataParser.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/15/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodDataParser : NSObject

+ (NSMutableDictionary *)foodDictionaryFromJson:(NSData *)data shortformArray:(NSArray *)shortformArray error:(NSError **)error;

@end
