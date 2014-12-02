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
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.7, 0.7); //TODO:moving down animation instead?
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
