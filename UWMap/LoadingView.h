//
//  LoadingView.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/15/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadingViewDelegate <NSObject>

- (void)refreshButtonTapped;

@end

@interface LoadingView : UIView

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (nonatomic, weak) id<LoadingViewDelegate> delegate;

@end
