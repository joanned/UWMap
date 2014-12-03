//
//  FoodDataFetcher.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FoodDataFetcherDelegate <NSObject>

- (void)foodDataFinishedLoading:(NSArray *)foodArray;

@end

@interface FoodDataFetcher : NSObject

@property (nonatomic, weak) id<FoodDataFetcherDelegate> delegate;

- (void)getFoodData;

@end
