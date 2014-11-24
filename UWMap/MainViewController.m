//
//  MainViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/23/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

//todo:
//fix zoomscale when you go back to map
//add all the data
//map jumps zoomscale in beginning

//second release:
//fOOD tings
//building hours
//location service

#import "MainViewController.h"
#import "BuildingListViewController.h"
#import "MapViewController.h"
#import "UIImageEffects.h"

const float kWhiteOverlayOpacity = 0.75f;

@interface MainViewController () <BuildingListViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) BuildingListViewController *buildingListViewController;

@property (nonatomic, strong) MapViewController *mapViewController;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *buildingIcon;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *searchBarView;
@property (nonatomic, assign) BOOL isOnMapView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic, assign) BOOL showFullList;

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
    self.searchBar.alpha = 0.93f;
    
    [self drawSearchbarShadow];
    [self setSearchBarColours];
    
    self.whiteView.alpha = 0;
    
    [self showMapView];
}

- (void)showTableView {
    [self setBlurredBackground];
    
    [self.iconImage setImage:[UIImage imageNamed:@"mapIcon"]];

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
    [self.iconImage setImage:[UIImage imageNamed:@"list"]];

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
        self.whiteView.alpha = kWhiteOverlayOpacity;
        self.buildingListViewController.whiteLayer.alpha = 0;
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.buildingListViewController.whiteLayer.alpha = kWhiteOverlayOpacity; //make this contants
        } completion:nil];
        
    } else {
        self.whiteView.hidden = NO;
        self.buildingListViewController.whiteLayer.alpha = 0.0f;
        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.whiteView.alpha = 0.0f;
        } completion:nil];
    }
}

- (void)tappedIcon:(UITapGestureRecognizer *)recognizer {
    if (self.isOnMapView == YES) {
        self.showFullList = YES;
        [self showTableView];
    } else {
        self.showFullList = NO;
        [self showMapView];
    }
}

#pragma mark - Childview controller

-(BuildingListViewController *)buildingListViewController {
    if (!_buildingListViewController) {
        self.buildingListViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([BuildingListViewController class])];
    }
    
    return  _buildingListViewController;
}

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
    
//    [UIView animateWithDuration:0.25f
//                          delay:0
//                        options:UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
                         [self.mapViewController adjustViewWithPoint:adjustedPoint];
//                     } completion:nil];
    
    
}

#pragma  mark - <UISearchBarDelegate>

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (self.isOnMapView) {
        [self showTableView];
        [self.buildingListViewController reloadTableWithText:@"filler text for a blank search"];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0 && self.showFullList == NO) {
        [self.buildingListViewController reloadTableWithText:@"filler text for a blank search"];
    } else {
        [self.buildingListViewController reloadTableWithText:searchText];
    }
}

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

- (void)drawSearchbarShadow {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.searchBarView.bounds];
    self.searchBarView.layer.masksToBounds = NO;
    self.searchBarView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.searchBarView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
    self.searchBarView.layer.shadowOpacity = 0.5f;
    self.searchBarView.layer.shadowPath = shadowPath.CGPath;
}

- (void)setSearchBarColours {
    //removes 1px line at bottom of searchbar
    [self.searchBar setBackgroundImage:[UIImage new]];
    
    //searchfield colour
    for (UIView* subview in [[self.searchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            [textField setBackgroundColor:[UIColor colorWithRed:25/255.0f green:25/255.0f blue:25/255.0f alpha:1]];
        }
    }
    
    //searchfield text color
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor colorWithWhite:1 alpha:0.8f]];
}

@end
