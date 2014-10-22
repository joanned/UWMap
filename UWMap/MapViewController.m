//
//  FirstViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//
//@import UIKIt;
#import <QuartzCore/QuartzCore.h>
#import "MapViewController.h"
#import "PinView.h"

@interface MapViewController () <BuildingListViewControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) BuildingListViewController *buildingListViewController;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
//@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *buildingIcon;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@property NSDictionary *locationDictionary;
@property NSArray *keys;



@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.frame = CGRectMake(0, 0, [[UIImage imageNamed:@"mapImage.png"] size].width-50, [[UIImage imageNamed:@"mapImage.png"] size].height-50);
    
//    [self.scrollView setClipsToBounds:YES];
//    self.scrollView.minimumZoomScale = 0.5;
//    self.scrollView.maximumZoomScale = 6.0;
//    self.scrollView.contentSize = CGSizeMake ([[UIImage imageNamed:@"mapImage.png"] size].width, [[UIImage imageNamed:@"mapImage.png"] size].height);
//    self.scrollView.delegate = self;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tappedBuildingIcon:)];
    [self.buildingIcon addGestureRecognizer:singleTap];
    
    self.buildingListViewController.delegate = self;
    
    self.imageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handlePinch:)];
    pinchRecognizer.delegate = self;
    [self.imageView addGestureRecognizer:pinchRecognizer];
    
    [self setupData];
    
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    pinchGestureRecognizer.view.transform = CGAffineTransformScale(pinchGestureRecognizer.view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    [tapRecognizer setNumberOfTapsRequired:1];
//    [tapRecognizer setDelegate:self];
//    [self.scrollView addGestureRecognizer:tapRecognizer];
    [self.imageView addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tappedScreen:(UITapGestureRecognizer *)recognizer {
    if(recognizer.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [recognizer locationInView:recognizer.view];
        NSLog(@"%@", NSStringFromCGPoint(point));
        
        for (NSString *locationKey in self.locationDictionary) {
            CGRect locationRect = [self findRectFromKey:locationKey];
            
            if (CGRectContainsPoint(locationRect, point)) {
                [self showDetails:locationRect withLabel:locationKey];
            }
        }
    }
}

- (CGRect)findRectFromKey:(NSString *)locationKey {
    NSValue *locationValue = [self.locationDictionary objectForKey:locationKey];
    return [locationValue CGRectValue];
}

- (void)showDetails:(CGRect)locationRect withLabel:(NSString *)label {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"pin" owner:self options:nil];
    PinView *mainView = [subviewArray objectAtIndex:0];
    mainView.frame = CGRectMake(CGRectGetMidX(locationRect),CGRectGetMidY(locationRect),50,50);
    mainView.pinLabel.text = label;
    
    [self.imageView addSubview:mainView];
}


- (void)setupData {
    self.locationDictionary = @{
                                @"Arts Lecture Hall" : [NSValue valueWithCGRect:CGRectMake(793, 694, 16, 16)],
                                @"Biology 1" : [NSValue valueWithCGRect:CGRectMake(793, 529, 16, 16)],
                                @"Biology 2" : [NSValue valueWithCGRect:CGRectMake(757, 500, 16, 16)],
                                @"B.C. Matthews Hall" : [NSValue valueWithCGRect:CGRectMake(789, 251, 16, 16)],
                                };
    
    self.keys = [self.locationDictionary allKeys];
}

- (void)tappedBuildingIcon:(UITapGestureRecognizer *)recognizer {
    [self showTableView];
}

- (void)showTableView {
    [self addChildViewController:self.buildingListViewController];
    self.buildingListViewController.view.frame = [self.containerView bounds];
    [self.containerView addSubview:self.buildingListViewController.view];
    [self.buildingListViewController didMoveToParentViewController:self];
}

- (void)hideTableView {
    [self.buildingListViewController willMoveToParentViewController:nil];
    [self.buildingListViewController.view removeFromSuperview];
    [self.buildingListViewController removeFromParentViewController];
}


#pragma mark <UIScrollViewDelegate>

//- (void)scrollViewDidZoom:(UIScrollView *)aScrollView
//{
//    for (UIView *dropPinView in self.imageView.subviews) {
//        CGRect oldFrame = dropPinView.frame;
//        // 0.5 means the anchor is centered on the x axis. 1 means the anchor is at the bottom of the view. If you comment out this line, the pin's center will stay where it is regardless of how much you zoom. I have it so that the bottom of the pin stays fixed. This should help user RomeoF.
//        [dropPinView.layer setAnchorPoint:CGPointMake(0.5, 1)];
//        dropPinView.frame = oldFrame;
//        // When you zoom in on scrollView, it gets a larger zoom scale value.
//        // You transform the pin by scaling it by the inverse of this value.
//        dropPinView.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);
//    }
//}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return self.imageView;
//}

#pragma mark - Childview controller

-(BuildingListViewController *)buildingListViewController {
    if (!_buildingListViewController) {
        self.buildingListViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([BuildingListViewController class])];
    }
    
    return  _buildingListViewController;
}

#pragma mark - <BuildingListViewControllerDelegate>

- (void)backButtonTapped {
    [self hideTableView];
}

- (void)selectedCellWithLabel:(NSString *)label {
    [self hideTableView];
    CGRect locationRect = [self findRectFromKey:label];
    [self showDetails:locationRect withLabel:label];
}


@end
