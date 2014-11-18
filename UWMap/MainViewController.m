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
    [self setBlurredBackground2];
    
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
    [self.searchBar resignFirstResponder];
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
        //blur background
        [self showTableView];
        [self.buildingListViewController reloadTableWithText:@""];
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
    UIGraphicsBeginImageContext(self.containerView.bounds.size);
    [self.containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlurFilter setDefaults];
    [gaussianBlurFilter setValue:[CIImage imageWithCGImage:[screenshotImage CGImage]] forKey:kCIInputImageKey];
    [gaussianBlurFilter setValue:@5 forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [gaussianBlurFilter outputImage];
    CIContext *context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    
    //ensure that the final image is the same size
    rect.origin.x        += (rect.size.width  - screenshotImage.size.width ) / 2;
    rect.origin.y        += (rect.size.height - screenshotImage.size.height) / 2;
    rect.size            = screenshotImage.size;
    
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    UIImage *blurredImage       = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    self.buildingListViewController.tableView.backgroundColor = [UIColor colorWithPatternImage:blurredImage];
}

- (void)setBlurredBackground2 {
    //reductionFactor to downsize blurred image
    CGFloat reductionFactor = 2;
    UIGraphicsBeginImageContext(CGSizeMake(self.containerView.frame.size.width/reductionFactor, self.containerView.frame.size.height/reductionFactor));
    [self.containerView drawViewHierarchyInRect:CGRectMake(0, 0, self.containerView.frame.size.width/reductionFactor, self.containerView.frame.size.height/reductionFactor) afterScreenUpdates:NO];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImage *blurredImage = [UIImageEffects imageByApplyingBlurToImage:screenshotImage withRadius:5 tintColor:[UIColor colorWithWhite:1 alpha:0.8] saturationDeltaFactor:1.6 maskImage:nil];
    
    [self.buildingListViewController.blurredImageView setImage:blurredImage];
    
}

@end
