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

#import "MainViewController.h"
#import "BuildingListViewController.h"
#import "MapViewController.h"
#import "UIImageEffects.h"
#import "FoodDetailsView.h"
#import "FoodDataFetcher.h"
#import "FoodData.h"
#import "Constants.h"
#import "PopupView.h"
#import "LoadingView.h"
#import "FoodDataParser.h"

const float kWhiteOverlayOpacity = 0.75f;

@interface MainViewController () <BuildingListViewControllerDelegate, FoodDetailsViewDelegate, UISearchBarDelegate, FoodDataFetcherDelegate, MapViewControllerDelegate, LoadingViewDelegate>

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

@property (nonatomic, strong) LoadingView *loadingView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.foodDictionary = [[NSDictionary alloc] init];
    
    self.mapViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MapViewController class])];
    
    self.isOnMapView = YES;
    self.showCombinedList = YES;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tappedIcon:)];
    [self.buildingIcon addGestureRecognizer:tapRecognizer];
    
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
    
    [self setupLoadingView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.foodDictionary == nil) {
        [self.foodDataFetcher getFoodData];
        [self showLoadingState];
    }
}

- (void)showTableView {
    [self setBlurredBackground];
    
    self.loadingView.hidden = YES;
    
    [self.iconImage setImage:[UIImage imageNamed:@"mapIcon"]];

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
    
    [self animateToTableview:YES];
}

- (void)showMapView {
    [self.iconImage setImage:[UIImage imageNamed:@"list"]];
    self.loadingView.hidden = NO;

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

- (void)animateToTableview:(BOOL)animateToTable { //todoL make this 2 diff methods
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

#pragma mark - LoadingView helpers

- (void)setupLoadingView {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil];
    self.loadingView = [subviewArray firstObject];
    self.loadingView.delegate = self;
    self.loadingView.center = CGPointMake(self.view.center.x, [[UIScreen mainScreen] bounds].size.height - self.loadingView.frame.size.height / 2.0f);
    [self.view addSubview:self.loadingView];
    [self showLoadingState];
}

- (void)showLoadingState {
    self.loadingView.loadingLabel.text = @"Loading food content...";
    [self.loadingView.loadingIndicator startAnimating];
    self.loadingView.loadingIndicator.hidden = NO;
    self.loadingView.refreshButton.hidden = YES;
}

- (void)showLoadingFailedState {
    self.loadingView.loadingLabel.text = @"Unable to load food content";
    [self.loadingView.loadingIndicator stopAnimating];
    self.loadingView.loadingIndicator.hidden = YES;
    self.loadingView.refreshButton.hidden = NO;
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
//        self.whiteView.alpha = 0.6f;
        self.foodDetailsView.alpha = 1.0f;
        self.foodDetailsView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:nil];

}

- (void)hideFoodDetailsView {
//    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        self.whiteView.alpha = 0;
//    } completion:nil];
    CGRect currentFoodViewFrame = self.foodDetailsView.frame;
    
    if (self.foodDetailsView) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.foodDetailsView.alpha = 0;
                             self.foodDetailsView.frame = CGRectMake(currentFoodViewFrame.origin.x, currentFoodViewFrame.origin.y + 12.0f, currentFoodViewFrame.size.width, currentFoodViewFrame.size.height);
                         } completion:^(BOOL finished) {
                             self.foodDetailsView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             [self.foodDetailsView removeFromSuperview];
                         }];
    }
}

- (void)setupFoodDetailsView {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"FoodDetailsView" owner:self options:nil];
    self.foodDetailsView = [subviewArray firstObject];
    
    self.foodDetailsView.delegate = self;
}

#pragma mark - <FoodDetailsViewDelegate>

- (void)foodDetailsCloseButtonTapped {
    [self hideFoodDetailsView];
}

- (void)updateTableViewHeight:(CGFloat)height {
    self.foodDetailsView.frame = CGRectMake(15, 84, [[UIScreen mainScreen] bounds].size.width - 30, height);
    [self.foodDetailsView setupShadows];
    [self.foodDetailsView setupGradientMask];
}

#pragma mark - <FoodDataFetcherDelegate> and Helpers

- (void)setupFetchingFoodData {
    self.foodDataFetcher = [[FoodDataFetcher alloc] init];
    self.foodDataFetcher.delegate = self;
//    [self.foodDataFetcher getFoodData];todo
//    [self showLoadingState];
}

- (void)foodDataFinishedLoading:(NSData *)foodData {
    self.foodDictionary = [self parseData:foodData]; //TODO: do we need to store the dictionary
    
//    [self sortFoodIntoArrays:foodDictionary];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapViewController showFoodIconsOnMap:self.foodDictionary];
        [self.buildingListViewController foodDictionaryLoaded:self.foodDictionary];
        
        [self.loadingView.loadingIndicator stopAnimating];
        [self.loadingView removeFromSuperview];
    });
}

- (void)foodDataFailedToLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.buildingListViewController foodLoadingFailed];
        [self showLoadingFailedState];
    });
}

- (NSDictionary *)parseData:(NSData *)foodData { //TODO: put this elsewhere
    NSArray *shortformArray = [self.mapViewController.shortformDictionary allKeys];
    
    NSError *error = nil;
    
    NSDictionary *foodDataDictionary = [FoodDataParser foodDictionaryFromJson:foodData shortformArray:shortformArray error:&error];
    
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

- (void)foodPopupTappedWithTitle:(NSString *)title {
    FoodData *foodData = [self.foodDictionary objectForKey:title];
    
    if (foodData != nil) {
        NSMutableArray *foodDataArray = [[NSMutableArray alloc] init];
        [foodDataArray addObject:foodData];
        
        [self.foodDetailsView setupDataWithFoodData:foodDataArray];
        [self showFoodDetailsView];
    }
}

- (void)foodPopupTappedWithArray:(NSMutableArray *)foodArray {
    [self.foodDetailsView setupDataWithFoodData:foodArray];
    [self showFoodDetailsView];
}

#pragma mark - <LoadingViewDelegate>

- (void)closeButtonTapped {
    [UIView animateWithDuration:0.25f animations:^{
        self.loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        self.loadingView.alpha = 1.0f;
        [self.loadingView removeFromSuperview];
    }];
}

@end
