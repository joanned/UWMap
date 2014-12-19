//
//  FirstViewController.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingListViewController.h"

@protocol MapViewControllerDelegate <NSObject>

- (void)foodPopupTappedWithTitle:(NSString *)title;
- (void)foodPopupTappedWithArray:(NSMutableArray *)array;

@end

@interface MapViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary *shortformDictionary;
@property (nonatomic, weak) id<MapViewControllerDelegate> delegate;

- (CGPoint)makePointFromBuildingKey:(NSString *)locationKey isFromTable:(BOOL)isFromTable;
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
- (void)showDetails:(CGPoint)locationRect withLabel:(NSString *)label;
- (void)adjustViewWithPoint:(CGPoint)locationPoint;
- (void)showFoodIconsOnMap:(NSDictionary *)foodDictionary;


@end
