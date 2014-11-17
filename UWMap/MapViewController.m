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

@interface MapViewController () <UIScrollViewDelegate>


@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) CGFloat originalImageWidth;
@property (nonatomic, assign) CGFloat originalImageHeight;
@property (nonatomic, assign) CGPoint startingPoint;
@property (nonatomic, assign) BOOL isFirstLoad;

@property NSDictionary *locationDictionary;
@property NSArray *buildingTitlesArray;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehaviour;
@property (nonatomic, strong) UICollisionBehavior *collisionBehaviour;
@property (nonatomic, strong) UIDynamicItemBehavior *itemBehaviour;

@property (nonatomic, strong) PopupView *currentPopupView;
@property (nonatomic ,assign) CGRect initialPopupFrame;
@property (nonatomic, assign) CGFloat initialMapScale;

@end

static const CGFloat kWidthOfPin = 30;

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    self.locationDictionary = [DataProvider buildingDictionary];
    self.buildingTitlesArray = [self.locationDictionary allKeys];
    
    self.originalImageWidth = self.imageView.frame.size.width;
    self.originalImageHeight = self.imageView.frame.size.height;
    
    self.isFirstLoad = YES;
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.gravityBehaviour = [[UIGravityBehavior alloc] init];
    self.collisionBehaviour = [[UICollisionBehavior alloc] init];
    self.itemBehaviour = [[UIDynamicItemBehavior alloc] init];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    UIImage *image = [UIImage imageNamed:@"Waterloo_map.png"];
    
    self.scrollView.contentSize = CGSizeMake ([image size].width, [image size].height);
    
    [self.scrollView setClipsToBounds:YES];
    CGFloat heightScale = self.scrollView.frame.size.height / self.scrollView.contentSize.height;
    self.scrollView.minimumZoomScale = heightScale;
    self.scrollView.maximumZoomScale = 1.3f;
    self.scrollView.zoomScale = heightScale + 0.4;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    //    [tapRecognizer setDelegate:self];
    [self.scrollView addGestureRecognizer:tapRecognizer];
    
    self.initialMapScale = self.scrollView.zoomScale;
    
//    NSLog(@"VIEW DID APPEAR: %@", NSStringFromCGSize(self.scrollView.contentSize));
//    NSLog(@"rect: %@", NSStringFromCGRect(self.imageView.frame));
//    NSLog(@"----");
//    NSLog(@"image height: %f", [image size].height);
    
    if (self.isFirstLoad == YES) {
        self.startingPoint = CGPointMake(2437.0/4446.0 * self.imageView.frame.size.width, 806.0/2730.0 * self.imageView.frame.size.height);
        [self adjustViewWithPoint:self.startingPoint];
        self.isFirstLoad = NO;
    }
    
}

- (void)setupData {
    self.locationDictionary = [DataProvider buildingDictionary];
    self.buildingTitlesArray = [self.locationDictionary allKeys];
}

- (void)tappedScreen:(UITapGestureRecognizer *)recognizer {
    if(recognizer.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [recognizer locationInView:recognizer.view];
        NSLog(@"~~~~~~IMAGEVIEW FRAME: %@", NSStringFromCGRect(self.imageView.frame));

        NSLog(@"%f %f", point.x / self.imageView.frame.size.width, point.y / self.imageView.frame.size.height);
        NSLog(@"%f %f", point.x , point.y);
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

    if (isFromTable == YES) {
        self.scrollView.zoomScale = 1;
    }
   
    Building *building = [self.locationDictionary objectForKey:locationKey];
    CGFloat scaledPositionX = building.positionX * self.imageView.frame.size.width;
    CGFloat scaledPositionY = building.positionY * self.imageView.frame.size.height;
    
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
    PopupView *popupView = [[PopupView alloc] initWithTitle:label detail:@""];
    
    popupView.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);

    CGRect f = popupView.frame;
    f.origin.x = locationPoint.x-popupView.frame.size.width/2;
    f.origin.y = locationPoint.y-25-popupView.frame.size.height;;
    popupView.frame = f;
    
    NSLog(@"shown at point %f %f", locationPoint.x / self.imageView.frame.size.width, locationPoint.y / self.imageView.frame.size.height);
    NSLog(@"shown at point %f %f", locationPoint.x , locationPoint.y);
    NSLog(@"popup frame: %@", NSStringFromCGRect(popupView.frame));
    NSLog(@"~~~~~~IMAGEVIEW FRAME: %@", NSStringFromCGRect(self.imageView.frame));
    NSLog(@"~~~~~~SCROLLVIEW FRAME: %@", NSStringFromCGSize([self.scrollView contentSize]));

    [self.imageView addSubview:popupView];
    
//
//
//    [self.gravityBehaviour addItem:popupView];
//    [self.collisionBehaviour addItem:popupView];
//    [self.collisionBehaviour addBoundaryWithIdentifier:@"barrier" fromPoint:CGPointMake(locationPoint.x-100, locationPoint.y) toPoint:CGPointMake(locationPoint.x+100, locationPoint.y)];
//    [self.itemBehaviour addItem:popupView];
//    self.itemBehaviour.elasticity = 0.47;
//    [self.animator addBehavior:self.gravityBehaviour];
//    [self.animator addBehavior:self.collisionBehaviour];
//    [self.animator addBehavior:self.itemBehaviour];
////    //TODO: remove behavious when done animating
    

    [self.imageView addSubview:popupView];
}

- (void)adjustViewWithPoint:(CGPoint)locationPoint {
#warning - check if this is accurate
    if (locationPoint.x + [[UIScreen mainScreen] bounds].size.width / 2 > self.imageView.frame.size.width ) {
        locationPoint.x -= self.imageView.frame.size.width - locationPoint.x;
    }
    if (locationPoint.y + [[UIScreen mainScreen] bounds].size.height / 2 > self.imageView.frame.size.height ) {
        locationPoint.y -= self.imageView.frame.size.height - locationPoint.y;
    }

    self.scrollView.contentOffset = locationPoint;
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    NSLog(@"iMGE SIZE: %@", NSStringFromCGRect(self.imageView.frame));
//    NSLog(@"SCROLLVIEW CONTENT: %@", NSStringFromCGSize(self.scrollView.contentSize));
}
//
- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    
////        UIView *popupView = [self.view.subviews lastObject];
        for (UIView *subview in self.imageView.subviews ) {
//            if ([subview isKindOfClass:[PopupView class]]) {
                CGRect oldFrame = subview.frame;
                // 0.5 means the anchor is centered on the x axis. 1 means the anchor is at the bottom of the view. If you comment out this line, the pin's center will stay where it is regardless of how much you zoom. I have it so that the bottom of the pin stays fixed. This should help user RomeoF.
                [subview.layer setAnchorPoint:CGPointMake(0.5, 1)];
                subview.frame = oldFrame;
                // When you zoom in on scrollView, it gets a larger zoom scale value.
                // You transform the pin by scaling it by the inverse of this value.
                subview.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);
//            }
            }
//
//    if (self.imageView.frame.size.height > 2000) {
//        
//    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
