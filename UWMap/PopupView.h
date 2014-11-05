//
//  PopupView.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 11/2/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIView {
    UILabel *titleLabel;
    UILabel *hoursLabel;
}

@property (nonatomic, assign) UILabel *title;
@property (nonatomic, assign) UILabel *hours;
@property (nonatomic, assign) CGGradientRef gradient;

- (id)initWithTitle:(NSString *)title hours:(NSString *)hours;

@end
