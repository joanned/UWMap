//
//  MainViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/23/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "MainViewController.h"
#import "BuildingListViewController.h"
#import "MapViewController.h"

@interface MainViewController () <BuildingListViewControllerDelegate>

@property (nonatomic, strong) BuildingListViewController *buildingListViewController;

@property (nonatomic, strong) MapViewController *mapViewController;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *buildingIcon;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, assign) BOOL isOnMapView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MapViewController class])];
    
    self.isOnMapView = YES;

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tappedIcon:)];
    [self.buildingIcon addGestureRecognizer:singleTap];
    
    self.buildingListViewController.delegate = self;
    
    [self showMapView];
}

- (void)tappedIcon:(UITapGestureRecognizer *)recognizer {
    if (self.isOnMapView == YES) {
        [self showTableView];
    } else {
        [self showMapView];
    }
}

- (void)showTableView {
    //show table view
    [self addChildViewController:self.buildingListViewController];
    self.buildingListViewController.view.frame = [self.containerView bounds];
    [self.containerView addSubview:self.buildingListViewController.view];
    [self.buildingListViewController didMoveToParentViewController:self];
    
    //hide map view
    [self.mapViewController willMoveToParentViewController:nil];
    [self.mapViewController.view removeFromSuperview];
    [self.mapViewController removeFromParentViewController];
    
    self.isOnMapView = NO;
}

- (void)showMapView {
    //show map view
    [self addChildViewController:self.mapViewController];
    self.mapViewController.view.frame = [self.containerView bounds];
    [self.containerView addSubview:self.mapViewController.view];
    [self.mapViewController didMoveToParentViewController:self];
    
    //hide table view
    [self.buildingListViewController willMoveToParentViewController:nil];
    [self.buildingListViewController.view removeFromSuperview];
    [self.buildingListViewController removeFromParentViewController];
    
    self.isOnMapView = YES;
}

#pragma mark - Childview controller

-(BuildingListViewController *)buildingListViewController {
    if (!_buildingListViewController) {
        self.buildingListViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([BuildingListViewController class])];
    }
    
    return  _buildingListViewController;
}

//-(MapViewController *)mapViewController {
//    if (!_mapViewController) {
//        self.mapViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MapViewController class])];
//    }
//    
//    return  _mapViewController;
//}

#pragma mark - <BuildingListViewControllerDelegate>

- (void)selectedCellWithLabel:(NSString *)label {
    [self showMapView];
    NSValue *locationPoint = [self.mapViewController findPointFromKey:label];
    CGRect locationRect = [self.mapViewController findRectFromKey:label];
    [self.mapViewController showDetails:locationRect withLabel:label];
    [self.mapViewController adjustViewWithPoint:locationPoint];
}

@end
