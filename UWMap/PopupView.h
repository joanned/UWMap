//
//  PopupView.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 11/2/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIView {
//    UIImageView *_iconView;
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    
//    __unsafe_unretained UIColor *_color;
    
    CGGradientRef _gradient;
}

@property (nonatomic, assign) UIImage *iconImage;
@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) NSString *detail;
@property (nonatomic, assign) UIColor *color;

@property (nonatomic, assign) CGFloat width;

- (id)initWithWidth:(CGFloat)width;
- (id)initWithTitle:(NSString *)title detail:(NSString *)detail hasIcon:(BOOL)hasIcon;
- (UIColor *)lightenColor:(UIColor *)oldColor value:(float)value;

@end
