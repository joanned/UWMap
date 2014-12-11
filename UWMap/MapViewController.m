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
#import "DataProvider.h"
#import "Building.h"
#import "Constants.h"
#import "FoodData.h"

@interface MapViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate> //todo: not needed

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) CGFloat originalImageWidth;
@property (nonatomic, assign) CGFloat originalImageHeight;
@property (nonatomic, assign) CGPoint startingPoint;
@property (nonatomic, assign) BOOL isFirstLoad;

@property NSMutableDictionary *locationDictionary;
//@property NSArray *buildingTitlesArray;

//@property NSMutableDictionary *allLocationsDictionary;

@property (nonatomic, strong) PopupView *currentPopupView;
@property (nonatomic ,assign) CGRect initialPopupFrame;
@property (nonatomic, assign) CGFloat initialMapScale;

@property (nonatomic, strong) PopupView *popupView;

@end

static const CGFloat kWidthOfPin = 50;

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    self.locationDictionary = [DataProvider buildingDictionary];
//    self.buildingTitlesArray = [self.locationDictionary allKeys];
    
    self.shortformDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.locationDictionary) {
        Building *building = [self.locationDictionary objectForKey:key];
        [self.shortformDictionary setObject:building forKeyedSubscript:building.shortform];
    }
    
    self.originalImageWidth = self.imageView.frame.size.width;
    self.originalImageHeight = self.imageView.frame.size.height;
    
    self.isFirstLoad = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    UIImage *image = [UIImage imageNamed:@"Waterloo_map.png"];
    
    self.scrollView.contentSize = CGSizeMake ([image size].width, [image size].height);
    
    [self.scrollView setClipsToBounds:YES];
    
    //TODO: FIX DIS LATER ........D8
//    if (self.isFirstLoad) {
        CGFloat heightScale = self.scrollView.frame.size.height / self.scrollView.contentSize.height;
//    
    self.scrollView.minimumZoomScale = heightScale;
    self.scrollView.maximumZoomScale = 1.3f;
    self.scrollView.zoomScale = heightScale + 0.4;
    
//    self.scrollView.minimumZoomScale = 1;
//    self.scrollView.maximumZoomScale = 1;
//    self.scrollView.zoomScale = 1;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];

    [self.scrollView addGestureRecognizer:tapRecognizer];
    
    if (self.isFirstLoad == YES) {
        self.startingPoint = CGPointMake(2403/kMapImageWidth * self.imageView.frame.size.width, 900/kMapImageHeight * self.imageView.frame.size.height); //todo: store random numbers in contants ~~~~~~~~
        [self adjustViewWithPoint:self.startingPoint];
        self.isFirstLoad = NO;
    }
    
}

- (void)setupData {
//    self.locationDictionary = [DataProvider buildingDictionary]; 
//    self.buildingTitlesArray = [self.locationDictionary allKeys];
}

//- (void)tappedPopup:(UITapGestureRecognizer *)recognizer {
//    if (recognizer.state == UIGestureRecognizerStateRecognized) {
//        if ([self.delegate respondsToSelector:@selector(subviewTappedWithLabel:)]) {
//            [self.delegate subviewTappedWithLabel:self.popupView.title];
//        }
//    }
//}

- (void)tappedScreen:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [recognizer locationInView:recognizer.view];
        
        if (self.popupView != nil && CGRectContainsPoint(self.popupView.frame, point)) {
            if ([self.delegate respondsToSelector:@selector(subviewTappedWithLabel:)]) {
                [self.delegate subviewTappedWithLabel:self.popupView.title];
            }
        } else {
            [self removePopupView];
            
            NSLog(@"%f %f", point.x / self.imageView.frame.size.width, point.y / self.imageView.frame.size.height);
            NSLog(@"%f %f", point.x*2, point.y*2 +10);
            
            for (NSString *locationKey in self.locationDictionary) {
                CGRect locationRect = [self makeRectFromBuildingKey:locationKey];
                
                if (CGRectContainsPoint(locationRect, point)) {
                    CGPoint realLocationPoint = [self makePointFromBuildingKey:locationKey isFromTable:YES];
                    [self showDetails:realLocationPoint withLabel:locationKey];
                }
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
    CGFloat rectWidth = self.imageView.frame.size.width / self.originalImageWidth * kWidthOfPin;
    CGFloat rectHeight = self.imageView.frame.size.height / self.originalImageHeight * kWidthOfPin;
    return CGRectMake(locationPoint.x, locationPoint.y, rectWidth, rectHeight);
}

- (void)showDetails:(CGPoint)locationPoint withLabel:(NSString *)label {
    [self removePopupView];
    
    self.popupView = [[PopupView alloc] initWithTitle:label detail:@"" hasIcon:NO];
    
    self.popupView.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);

    CGRect frame = self.popupView.frame;
    frame.origin.x = locationPoint.x-frame.size.width/2 + kWidthOfPin/2;
    frame.origin.y = locationPoint.y-frame.size.height + 3;
    self.popupView.frame = frame;
    
    NSLog(@"shown at point %f %f", locationPoint.x , locationPoint.y);
    NSLog(@"popup frame: %@", NSStringFromCGRect(self.popupView.frame));
    NSLog(@"~~~~~~IMAGEVIEW FRAME: %@", NSStringFromCGRect(self.imageView.frame));
    NSLog(@"~~~~~~SCROLLVIEW FRAME: %@", NSStringFromCGSize([self.scrollView contentSize]));

    [UIView transitionWithView:self.imageView duration:0.2f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.imageView addSubview:self.popupView];
    } completion:nil];
    
    //adjust view if popup is cutoff
    CGRect popupRect = [self.popupView convertRect:self.popupView.bounds toView:self.view.superview];
    NSLog(@"popup frame: %@", NSStringFromCGRect(self.popupView.frame));
    NSLog(@"popup frame superview: %@", NSStringFromCGRect(popupRect));
    
    CGPoint popupPoint = self.scrollView.contentOffset;
    CGFloat positionX = popupRect.origin.x;
    if (positionX < 0) {
        popupPoint.x += positionX;
    } else if (positionX + self.popupView.width > [[UIScreen mainScreen] bounds].size.width) {
        popupPoint.x += self.popupView.width - [[UIScreen mainScreen] bounds].size.width + positionX; //refactor later (save screenwidth size somewhere)
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
    
////TODO: if (isfOOOOOD) {
//    self.popupView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapPopupRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedPopup:)];
//    tapPopupRecognizer.numberOfTapsRequired = 1;
////    tapPopupRecognizer.delegate = self.popupView;
//    tapPopupRecognizer.cancelsTouchesInView = NO;
//    [self.popupView addGestureRecognizer:tapPopupRecognizer];
    
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
//    for (NSString *key in foodDictionary) { //todo: scrap
//        FoodData *foodData = [foodDictionary objectForKey:key];
//        
//        UIImageView *foodIconView = [[UIImageView alloc] init];
//        UIImage *iconImage = nil;
//
//        if ([foodData.title rangeOfString:@"Tim Hortons"].location == NSNotFound) {
//            iconImage = [UIImage imageNamed:@"first"];
//        } else {
//            iconImage = [UIImage imageNamed:@"icon2"];
//        }
//        
//        [foodIconView setImage:iconImage];
//        
//        CGFloat  currentScale = self.scrollView.zoomScale;
//        CGFloat xPosition = (foodData.xPosition - kXMapStartPosition) * kScaleForFood ;
//        CGFloat yPosition = (foodData.yPosition - kYMapStartPosition) * kScaleForFood ;
////        foodIconView.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);
//        
//        foodIconView.frame = CGRectMake(xPosition, yPosition, iconImage.size.width, iconImage.size.height);
//        
//        //TODO: animate
//        self.scrollView.zoomScale = 1;
//        [self.imageView addSubview:foodIconView];
//        self.scrollView.zoomScale = currentScale;
//    }
    
       [self.locationDictionary addEntriesFromDictionary:foodDictionary];
    
   
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    for (UIView *subview in self.imageView.subviews ) {
        CGRect oldFrame = subview.frame;
        // 0.5 means the anchor is centered on the x axis. 1 means the anchor is at the bottom of the view. If you comment out this line, the pin's center will stay where it is regardless of how much you zoom. I have it so that the bottom of the pin stays fixed. This should help user RomeoF.
        [subview.layer setAnchorPoint:CGPointMake(0.5, 1)];
        subview.frame = oldFrame;
        // When you zoom in on scrollView, it gets a larger zoom scale value.
        // You transform the pin by scaling it by the inverse of this value.
        subview.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);
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

@end
