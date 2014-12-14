//
//  PopupView.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 11/2/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupViewDelegate <NSObject>

- (void)popupTappedWithTitle:(NSString *)title;

@end

@interface PopupView : UIView {
//    UIImageView *_iconView;
    UILabel *_titleLabel;
    UILabel *_detailLabel; //todo: needed?
    
    CGGradientRef _gradient;
}

@property (nonatomic, weak) id<PopupViewDelegate> delegate;
@property (nonatomic, assign) UIImage *iconImage;
@property (nonatomic, assign) NSString *popupTitle;
@property (nonatomic, assign) NSString *detail;
@property (nonatomic, assign) UIColor *color;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) NSString *locationBuilding; //todo; suppposed to be assign or w0t

- (id)initWithWidth:(CGFloat)width;
- (id)initWithTitle:(NSString *)title detail:(NSString *)detail hasIcon:(BOOL)hasIcon;
- (UIColor *)lightenColor:(UIColor *)oldColor value:(float)value; //todo: needed?
- (id)initWithNumberOfFoodLocations:(NSInteger)numberOfFoodLocations locationBuilding:(NSString *)locationBuilding;


@end
