//
//  MainViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/23/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

//todo:
//fix zoomscale when you go back to map
//map jumps zoomscale in beginning
//app icon and launch image
//fix unable to click points after zooming out a lot

//second release:
//location service

#import "MainViewController.h"
#import "BuildingListViewController.h"
#import "MapViewController.h"
#import "UIImageEffects.h"
#import "FoodDetailsView.h"
#import "FoodDataFetcher.h"
#import "FoodData.h"
#import "DataProvider.h"
#import "Constants.h"

const float kWhiteOverlayOpacity = 0.75f;

@interface MainViewController () <BuildingListViewControllerDelegate, FoodDetailsViewDelegate, UISearchBarDelegate, FoodDataFetcherDelegate, MapViewControllerDelegate>

@property (nonatomic, strong) BuildingListViewController *buildingListViewController;

@property (nonatomic, strong) MapViewController *mapViewController;

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UIImageView *buildingIcon;
@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIView *searchBarView;
@property (nonatomic, weak) IBOutlet UIView *whiteView;
@property (nonatomic, weak) IBOutlet UIImageView *iconImage;

@property (nonatomic, assign) BOOL showFullList; //TODO: can just use isonmapview?
@property (nonatomic, assign) BOOL isOnMapView; //get rid of these/make them states later.....D8
@property (nonatomic, assign) BOOL showCombinedList;

@property (nonatomic, strong) FoodDetailsView *foodDetailsView;

@property (nonatomic, strong) FoodDataFetcher *foodDataFetcher;
@property (nonatomic, strong) NSDictionary *foodDictionary; //goes here or mapviewcontrooler?
//@property (nonatomic, strong) NSMutableArray *foodLocationsArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.foodDictionary = [[NSDictionary alloc] init];
    
    self.mapViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MapViewController class])];
    
    self.isOnMapView = YES;
    self.showCombinedList = YES;

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tappedIcon:)];
    [self.buildingIcon addGestureRecognizer:singleTap];
    
    self.buildingListViewController.delegate = self;
    self.mapViewController.delegate = self;
    self.buildingListViewController.showCombinedList = YES;
    
    self.searchBar.delegate = self;
    self.searchBar.alpha = 0.93f;
    
    [self drawSearchbarShadow];
    [self setSearchBarColours];
    
    self.whiteView.alpha = 0;
    
    [self showMapView];
    
    [self setupFetchingFoodData];
    
    [self setupFoodDetailsView];
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
    self.showCombinedList = YES;
    
    [self.searchBar resignFirstResponder];
    
    [self animateToTableview:NO];
}

- (void)animateToTableview:(BOOL)animateToTable {
    if (animateToTable) {
        self.whiteView.hidden = YES;
        self.whiteView.alpha = kWhiteOverlayOpacity;
        self.buildingListViewController.whiteLayer.alpha = 0;
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.buildingListViewController.whiteLayer.alpha = kWhiteOverlayOpacity;
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
        [self hideFoodDetailsView];
        self.showFullList = YES; //too many dumb bools..... TODO
        self.showCombinedList = NO;
        self.buildingListViewController.showCombinedList = NO;
        [self showTableView];
    } else {
        self.showFullList = NO;
        self.buildingListViewController.showCombinedList = YES;
        [self showMapView];
    }
}

#pragma mark - Childview controller override

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
    
    CGPoint locationPoint = [self.mapViewController makePointFromBuildingKey:label isFromTable:YES];
    [self.mapViewController showDetails:locationPoint withLabel:label];
    
    CGFloat zoomScale = self.mapViewController.scrollView.zoomScale;
    CGFloat adjustedX = locationPoint.x * zoomScale - [[UIScreen mainScreen] bounds].size.width / 2;
    CGFloat adjustedY = locationPoint.y * zoomScale - [[UIScreen mainScreen] bounds].size.height / 2;
        
    CGPoint adjustedPoint = CGPointMake(adjustedX, adjustedY);
    
    CGPoint currentOffset = self.mapViewController.scrollView.contentOffset;
    
    //if the distance to animate is too big, move the offset closer so the animation looks better
    CGFloat pointDistanceX = currentOffset.x - adjustedPoint.x;
    if (abs(pointDistanceX) > kMaxDistanceToAnimate) {
        if (pointDistanceX > 0) {
            currentOffset.x -= currentOffset.x - adjustedPoint.x - kMaxDistanceToAnimate;
        } else {
            currentOffset.x += adjustedPoint.x - currentOffset.x - kMaxDistanceToAnimate;
        }
        self.mapViewController.scrollView.contentOffset = currentOffset;
    }
    
    CGFloat pointDistanceY = currentOffset.y - adjustedPoint.y;
    if (abs(pointDistanceY) > kMaxDistanceToAnimate) {
        if (pointDistanceY > 0) {
            currentOffset.x -= currentOffset.x - adjustedPoint.x - kMaxDistanceToAnimate;
        } else {
            currentOffset.x += adjustedPoint.x - currentOffset.x - kMaxDistanceToAnimate;
        }
        self.mapViewController.scrollView.contentOffset = currentOffset;
    }

    [UIView animateWithDuration:0.35f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.mapViewController adjustViewWithPoint:adjustedPoint];
                     } completion:nil];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma  mark - <UISearchBarDelegate>

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (self.isOnMapView) {
        [self hideFoodDetailsView];
        [self showTableView];
        [self.buildingListViewController reloadTableWithText:@"filler text for a blank search" showFullList:self.showCombinedList];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0 && self.showFullList == NO) {
        [self.buildingListViewController reloadTableWithText:@"filler text for a blank search" showFullList:self.showCombinedList];
    } else {
        [self.buildingListViewController reloadTableWithText:searchText showFullList:self.showCombinedList];
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

#pragma mark - Food Details helpers

- (void)showFoodDetailsView {
    [self.view addSubview:self.foodDetailsView];
    
    self.foodDetailsView.alpha = 0;
    self.foodDetailsView.transform = CGAffineTransformMakeScale(0.8, 0.8); //UP DOWN INSTEAD???
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.whiteView.alpha = 0.6f;
        self.foodDetailsView.alpha = 1.0f;
        self.foodDetailsView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:nil];

}

- (void)hideFoodDetailsView {
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.whiteView.alpha = 0;
    } completion:nil];
    
    if (self.foodDetailsView) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.foodDetailsView.alpha = 0;
                             self.foodDetailsView.transform = CGAffineTransformMakeScale(0.7, 0.7); //TODO:moving down animation instead?
                         } completion:^(BOOL finished) {
                             [self.foodDetailsView removeFromSuperview];
                         }];
    }
}

- (void)setupFoodDetailsView {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"FoodDetailsView" owner:self options:nil];
    self.foodDetailsView = [subviewArray firstObject];
#warning make dynamic ---
    self.foodDetailsView.frame = CGRectMake(20, 84, [[UIScreen mainScreen] bounds].size.width - 40, [[UIScreen mainScreen] bounds].size.height - 84 - 20); //TODO
    self.foodDetailsView.delegate = self;
    
    [self.foodDetailsView setupShadowsWithFrame:CGRectZero];
}

#pragma mark - <FoodDetailsViewDelegate>

- (void)foodDetailsCloseButtonTapped {
    [self hideFoodDetailsView];
}

#pragma mark - <FoodDataFetcherDelegate> and Helpers

- (void)setupFetchingFoodData {
    self.foodDataFetcher = [[FoodDataFetcher alloc] init];
    self.foodDataFetcher.delegate = self;
    [self.foodDataFetcher getFoodData];
}

- (void)foodDataFinishedLoading:(NSData *)foodData {
    self.foodDictionary = [self parseData:foodData]; //TODO: do we need to store the dictionary
    
    
//    [self sortFoodIntoArrays:foodDictionary];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapViewController showFoodIconsOnMap:self.foodDictionary];
        [self.buildingListViewController foodDictionaryLoaded:self.foodDictionary];
    });

}

- (NSDictionary *)parseData:(NSData *)foodData { //TODO: put this elsewhere
    NSArray *shortformArray = [self.mapViewController.shortformDictionary allKeys];
    
    NSError *error = nil;
    NSDictionary *foodDataDictionary = [DataProvider foodDictionaryFromJson:foodData shortformArray:shortformArray error:&error];
    
    if (error) {
        NSLog(@"parsing data failed with error: %@", [error localizedDescription]); //TODO: show error on app
        return nil;
    } else {
        return foodDataDictionary;
    }
}

//- (void)sortFoodIntoArrays:(NSDictionary *)foodDictionary {
//    self.foodLocationsArray = [[NSMutableArray alloc] init];
//    
//}

#pragma mark <MapViewControllerDelegate>

- (void)subviewTappedWithLabel:(NSString *)label {
    FoodData *foodData = [self.foodDictionary objectForKey:label];
    
    NSMutableArray *foodDataArray = [[NSMutableArray alloc] init];
    [foodDataArray addObject:foodData];
    
    [self.foodDetailsView setupDataWithFoodData:foodDataArray];
    
//    self.foodDetailsView.titleLabel.text = foodData.title;
//    
//    if (foodData.foodDescription != nil) {
//        self.foodDetailsView.descriptionLabel.text = foodData.foodDescription;
//    } else {
//        self.foodDetailsView.descriptionLabel.hidden = YES;
//    }
    [self showFoodDetailsView];
}

@end
