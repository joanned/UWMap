//
//  FirstViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MapViewController.h"
#import "PopupView.h"
#import "BuildingDataProvider.h"
#import "Building.h"
#import "Constants.h"
#import "FoodData.h"

@interface MapViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate, PopupViewDelegate> //todo: not needed

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) CGFloat originalImageWidth;
@property (nonatomic, assign) CGFloat originalImageHeight;
@property (nonatomic, assign) CGPoint startingPoint;
@property (nonatomic, assign) BOOL isFirstLoad;

@property NSMutableDictionary *locationDictionary;
@property NSMutableDictionary *foodAtLocationDictionary;

@property (nonatomic ,assign) CGRect initialPopupFrame;
@property (nonatomic, assign) CGFloat initialMapScale;

@property (nonatomic, strong) PopupView *popupView;

@property (nonatomic, assign) CGFloat defaultZoomScale;
@property (nonatomic, assign) CGFloat savedZoomScale;

@end

static const CGFloat kWidthOfPin = 50;

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    self.locationDictionary = [BuildingDataProvider buildingDictionary];
    
    self.shortformDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.locationDictionary) {
        Building *building = [self.locationDictionary objectForKey:key];
        [self.shortformDictionary setObject:building forKeyedSubscript:building.shortform];
    }
    
    self.originalImageWidth = self.imageView.frame.size.width;
    self.originalImageHeight = self.imageView.frame.size.height;
    
    self.isFirstLoad = YES;
    
    self.savedZoomScale = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    UIImage *image = [UIImage imageNamed:@"Waterloo_map.png"];
    
    self.scrollView.contentSize = CGSizeMake ([image size].width, [image size].height);
    
    [self.scrollView setClipsToBounds:YES];

    if (self.isFirstLoad) {
        self.defaultZoomScale = self.scrollView.frame.size.height / self.scrollView.contentSize.height + 0.4f;
    }
    
    self.scrollView.minimumZoomScale = self.defaultZoomScale - 0.4;
    self.scrollView.maximumZoomScale = 1.3f;
    
    if (self.savedZoomScale == 0) {
        self.scrollView.zoomScale = self.defaultZoomScale;
    } else {
        self.scrollView.zoomScale = self.savedZoomScale;
    }

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];

    [self.scrollView addGestureRecognizer:tapRecognizer];
    
    if (self.isFirstLoad == YES) {
        self.startingPoint = CGPointMake(2403/kMapImageWidth * self.imageView.frame.size.width, 900/kMapImageHeight * self.imageView.frame.size.height); //todo: store random numbers in contants ~~~~~~~~
        [self adjustViewWithPoint:self.startingPoint];
        self.isFirstLoad = NO;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.savedZoomScale = self.scrollView.zoomScale;
}

- (void)tappedScreen:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [recognizer locationInView:recognizer.view];
        
        [self removePopupView];
        
        for (NSString *locationKey in self.locationDictionary) {
            CGRect locationRect = [self makeRectFromBuildingKey:locationKey];
            
            if (CGRectContainsPoint(locationRect, point)) {
                CGPoint realLocationPoint = [self makePointFromBuildingKey:locationKey isFromTable:YES];
                [self showDetails:realLocationPoint withLabel:locationKey];
            }
        }
    }
}

- (CGPoint)makePointFromBuildingKey:(NSString *)locationKey isFromTable:(BOOL)isFromTable {
    CGFloat  currentScale = self.scrollView.zoomScale;

    if (isFromTable == YES) { //todo: remove dis hackiness later . . e n e
        self.scrollView.zoomScale = 1;
    }
    
    CGFloat scaledPositionX;
    CGFloat scaledPositionY;
    Building *building = nil;
   
    if ([[self.locationDictionary objectForKey:locationKey] isKindOfClass:[Building class]]) {
        building = [self.locationDictionary objectForKey:locationKey];
        scaledPositionX = building.positionX * self.imageView.frame.size.width - kWidthOfPin/2;
        scaledPositionY = building.positionY * self.imageView.frame.size.height;
    } else {
        FoodData *foodData = [self.locationDictionary objectForKey:locationKey];
        building = [self.shortformDictionary objectForKey:foodData.building];
        scaledPositionX = building.positionX * self.imageView.frame.size.width - kWidthOfPin/2;
        scaledPositionY = building.positionY * self.imageView.frame.size.height;
    }
    
    if (isFromTable == YES) {
        self.scrollView.zoomScale = currentScale;
    }
    
    return CGPointMake(scaledPositionX, scaledPositionY);
}

- (CGRect)makeRectFromBuildingKey:(NSString *)locationKey {
    CGPoint locationPoint = [self makePointFromBuildingKey:locationKey isFromTable:NO];

    CGFloat clickableArea = kWidthOfPin * self.scrollView.zoomScale + 15.0f;
    return CGRectMake(locationPoint.x, locationPoint.y, clickableArea, clickableArea);
}

- (void)showDetails:(CGPoint)locationPoint withLabel:(NSString *)label {
    [self removePopupView];
    
    self.popupView = [[PopupView alloc] initWithTitle:label detail:@"" hasIcon:NO];
    
    self.popupView.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);

    CGRect frame = self.popupView.frame;
    frame.origin.x = locationPoint.x-frame.size.width/2 + kWidthOfPin/2;
    frame.origin.y = locationPoint.y-frame.size.height + 3;
    self.popupView.frame = frame;

    [UIView transitionWithView:self.imageView duration:0.2f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.imageView addSubview:self.popupView];
        self.popupView.delegate = self;
    } completion:nil];
    
    //adjust view if popup is cutoff
    CGRect popupRect = [self.popupView convertRect:self.popupView.bounds toView:self.view.superview];
    
    CGPoint popupPoint = self.scrollView.contentOffset;
    CGFloat positionX = popupRect.origin.x;
    if (positionX < 0) {
        popupPoint.x += positionX;
    } else if (positionX + self.popupView.width > [[UIScreen mainScreen] bounds].size.width) {
        popupPoint.x += self.popupView.width - [[UIScreen mainScreen] bounds].size.width + positionX;
    }
    
    CGFloat positionY = popupRect.origin.y;
    if (positionY < 64) { //change dis random number later
        popupPoint.y -= 64 - positionY;
    }
    
    [UIView animateWithDuration:0.25f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.contentOffset = popupPoint;
                     } completion:nil];
    
    self.savedZoomScale = self.defaultZoomScale;
}

- (void)adjustViewWithPoint:(CGPoint)locationPoint {
    if (locationPoint.x + [[UIScreen mainScreen] bounds].size.width / 2 > self.imageView.frame.size.width ) {
        locationPoint.x -= self.imageView.frame.size.width - locationPoint.x;
    }
    if (locationPoint.y + [[UIScreen mainScreen] bounds].size.height / 2 > self.imageView.frame.size.height ) {
        locationPoint.y -= self.imageView.frame.size.height - locationPoint.y;
    }

    self.scrollView.contentOffset = locationPoint;
}

- (void)showFoodIconsOnMap:(NSDictionary *)foodDictionary {
    self.foodAtLocationDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in foodDictionary) {
        FoodData *foodData = [foodDictionary objectForKey:key];
        NSMutableArray *foodArray = [self.foodAtLocationDictionary objectForKey:foodData.building];
        
        if (foodArray == nil) {
            foodArray = [[NSMutableArray alloc] init];
            [foodArray addObject:foodData];
            [self.foodAtLocationDictionary setObject:foodArray forKey:foodData.building];
        } else {
            [foodArray addObject:foodData];
            [self.foodAtLocationDictionary setObject:foodArray forKey:foodData.building];
        }
    }
    
    for (NSString *key in self.foodAtLocationDictionary) {
        NSMutableArray *foodArray = [self.foodAtLocationDictionary objectForKey:key];
        PopupView *foodPopupView = [[PopupView alloc] initWithNumberOfFoodLocations:[foodArray count] locationBuilding:key];
        
        Building *buildingForFood = [self.shortformDictionary objectForKey:key];
        
        CGFloat currentZoomScale = self.scrollView.zoomScale;
        
        CGFloat positionX = buildingForFood.positionX * self.imageView.frame.size.width / currentZoomScale - kWidthOfPin / 2; //todo: make helper for this stuff, also used in showdetails
        CGFloat positionY = buildingForFood.positionY * self.imageView.frame.size.height / currentZoomScale - foodPopupView.frame.size.height;
        
        foodPopupView.frame = CGRectMake(positionX, positionY, foodPopupView.frame.size.width, foodPopupView.frame.size.height);
        
        [UIView transitionWithView:self.imageView duration:0.2f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.imageView addSubview:foodPopupView];
        } completion:nil];
        
        foodPopupView.delegate = self;
        
    }
    
    [self.locationDictionary addEntriesFromDictionary:foodDictionary];
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
//    for (UIView *subview in self.imageView.subviews ) {
    if (self.popupView != nil) {
        CGRect oldFrame = self.popupView.frame;
        // 0.5 means the anchor is centered on the x axis. 1 means the anchor is at the bottom of the view. If you comment out this line, the pin's center will stay where it is regardless of how much you zoom. I have it so that the bottom of the pin stays fixed. This should help user RomeoF.
        [self.popupView.layer setAnchorPoint:CGPointMake(0.5, 1)];
        self.popupView.frame = oldFrame;
        // When you zoom in on scrollView, it gets a larger zoom scale value.
        // You transform the pin by scaling it by the inverse of this value.
        self.popupView.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - Helpers

- (void)removePopupView {
    if (self.popupView) {
        [UIView transitionWithView:self.imageView duration:0.2f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.popupView removeFromSuperview];
        } completion:nil];
    }
}

#pragma mark - <PopupViewDelegate>

- (void)popupTappedWithTitle:(NSString *)title {
    if ([self.delegate respondsToSelector:@selector(foodPopupTappedWithTitle:)]) {
        NSMutableArray *foodArray = [ self.foodAtLocationDictionary objectForKey:title];
        if (foodArray != nil) { //todo: think of better way to do this instead of nil checking
            [self.delegate foodPopupTappedWithArray:foodArray];
        } else {
            [self.delegate foodPopupTappedWithTitle:title];
        }
    }
}

@end
