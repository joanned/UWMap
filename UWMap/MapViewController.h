//
//  FirstViewController.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UIScrollViewDelegate <NSObject>

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;

@end

@interface MapViewController : UIViewController

@end
