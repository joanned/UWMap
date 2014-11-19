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
#import "UIImageEffects.h"

@interface MainViewController () <BuildingListViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) BuildingListViewController *buildingListViewController;

@property (nonatomic, strong) MapViewController *mapViewController;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *buildingIcon;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, assign) BOOL isOnMapView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

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
    
    self.searchBar.delegate = self;
    
    self.whiteView.alpha = 0;
    
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
    [self setBlurredBackground];

    //show table view
    [self addChildViewController:self.buildingListViewController];
    self.buildingListViewController.view.frame = [self.containerView bounds];
    
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        [self.containerView addSubview:self.buildingListViewController.view];
    } completion:nil];
    
    
    [self.buildingListViewController didMoveToParentViewController:self];
    
    //hide map view
    [self.mapViewController willMoveToParentViewController:nil];
    [self.mapViewController.view removeFromSuperview];
    [self.mapViewController removeFromParentViewController];
    
    self.isOnMapView = NO;
    
    [self animateToTableview:YES];
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
    [self.searchBar resignFirstResponder];
    
    [self animateToTableview:NO];
}

- (void)animateToTableview:(BOOL)animateToTable {
    if (animateToTable) {
        self.whiteView.hidden = YES;
        self.whiteView.alpha = 0.65f;
        self.buildingListViewController.whiteLayer.alpha = 0;
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.buildingListViewController.whiteLayer.alpha = 0.65; //make this contants
        } completion:nil];
        
    } else {
        self.whiteView.hidden = NO;
        self.buildingListViewController.whiteLayer.alpha = 0.0f;
        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.whiteView.alpha = 0.0f;
        } completion:nil];
    }
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
    self.searchBar.text = @"";
    [self showMapView];
    
    
    //make map default scale
    
    CGPoint locationPoint = [self.mapViewController makePointFromBuildingKey:label isFromTable:YES];
    [self.mapViewController showDetails:locationPoint withLabel:label];
    
    CGFloat zoomScale = self.mapViewController.scrollView.zoomScale;
    CGFloat adjustedX = locationPoint.x * zoomScale - [[UIScreen mainScreen] bounds].size.width / 2;
    CGFloat adjustedY = locationPoint.y * zoomScale - [[UIScreen mainScreen] bounds].size.height / 2;
        
    CGPoint adjustedPoint = CGPointMake(adjustedX, adjustedY);
    [self.mapViewController adjustViewWithPoint:adjustedPoint];
}

#pragma  mark - <UISearchBarDelegate>

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (self.isOnMapView) {
//        [UIView animateWithDuration:2.0f animations:^{
            [self showTableView];
            [self.buildingListViewController reloadTableWithText:@""];
//        }];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.buildingListViewController reloadTableWithText:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
}

//#pragma mark - search helper
//
//- (void)updateSearchWithText:(NSString *)searchText {
//    [self showTableView];
//}

#pragma mark - Helpers

- (void)setBlurredBackground {
    //reductionFactor to downsize blurred image
    CGFloat reductionFactor = 2;
    UIGraphicsBeginImageContext(CGSizeMake(self.containerView.frame.size.width/reductionFactor, self.containerView.frame.size.height/reductionFactor));
    [self.containerView drawViewHierarchyInRect:CGRectMake(0, 0, self.containerView.frame.size.width/reductionFactor, self.containerView.frame.size.height/reductionFactor) afterScreenUpdates:NO];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *blurredImage = [UIImageEffects imageByApplyingBlurToImage:screenshotImage withRadius:5 tintColor:[UIColor colorWithWhite:1 alpha:0.5] saturationDeltaFactor:1.4 maskImage:nil];
    
    [self.buildingListViewController.blurredImageView setImage:blurredImage];
    
}

@end
