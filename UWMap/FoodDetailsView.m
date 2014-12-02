//
//  FoodDetails.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "FoodDetailsView.h"

@interface FoodDetailsView ()



@end

@implementation FoodDetailsView

- (IBAction)closeButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(foodDetailsCloseButtonTapped)]) {
        [self.delegate foodDetailsCloseButtonTapped];
    }
}

@end
