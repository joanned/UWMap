//
//  FoodDetails.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodData.h"

@protocol FoodDetailsViewDelegate <NSObject>

- (void)foodDetailsCloseButtonTapped;

@end

@interface FoodDetailsView : UIView

@property (nonatomic, weak) id<FoodDetailsViewDelegate>delegate;

- (void)setupDataWithFoodData:(NSMutableArray *)foodDataArray;
- (void)setupShadowsWithFrame:(CGRect)frame;

@end
