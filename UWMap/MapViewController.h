//
//  FirstViewController.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingListViewController.h"

@interface MapViewController : UIViewController

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
- (void)showDetails:(CGRect)locationRect withLabel:(NSString *)label;
- (CGRect)findRectFromKey:(NSString *)locationKey;
- (CGPoint)findPointFromKey:(NSString *)locationKey;
- (void)adjustViewWithPoint:(NSValue *)locationPoint;
- (void)setupData;


@end
