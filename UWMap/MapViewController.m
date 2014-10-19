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

@interface MapViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property NSDictionary *locationDictionary;
@property NSArray *keys;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.frame = CGRectMake(0, 0, [[UIImage imageNamed:@"mapImage.png"] size].width-50, [[UIImage imageNamed:@"mapImage.png"] size].height-50);
//    UIImageView *pinImageView = [[UIImageView alloc] init];
//    
//    UIImage *pinImage = [UIImage imageNamed:@"bubble.png"];
//    [pinImageView setImage:pinImage];
//    [self.imageView addSubview:pinImageView];
    
    
    


    
    [self.scrollView setClipsToBounds:YES];
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 6.0;
    self.scrollView.contentSize = CGSizeMake ([[UIImage imageNamed:@"mapImage.png"] size].width, [[UIImage imageNamed:@"mapImage.png"] size].height);
    self.scrollView.delegate = self;
    
    [self setupData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    [tapRecognizer setNumberOfTapsRequired:1];
//    [tapRecognizer setDelegate:self];
    [self.scrollView addGestureRecognizer:tapRecognizer];
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
            NSValue *locationValue = [self.locationDictionary objectForKey:locationKey];
            CGRect locationRect = [locationValue CGRectValue];
            
            if (CGRectContainsPoint(locationRect, point)) {
                NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"pin" owner:self options:nil];
                PinView *mainView = [subviewArray objectAtIndex:0];
                mainView.frame = CGRectMake(CGRectGetMidX(locationRect),CGRectGetMidY(locationRect),50,50);
                mainView.pinLabel.text = locationKey;
                
                [self.imageView addSubview:mainView];
            }
        }
    }
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

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView
{
    for (UIView *dropPinView in self.imageView.subviews) {
        CGRect oldFrame = dropPinView.frame;
        // 0.5 means the anchor is centered on the x axis. 1 means the anchor is at the bottom of the view. If you comment out this line, the pin's center will stay where it is regardless of how much you zoom. I have it so that the bottom of the pin stays fixed. This should help user RomeoF.
        [dropPinView.layer setAnchorPoint:CGPointMake(0.5, 1)];
        dropPinView.frame = oldFrame;
        // When you zoom in on scrollView, it gets a larger zoom scale value.
        // You transform the pin by scaling it by the inverse of this value.
        dropPinView.transform = CGAffineTransformMakeScale(1.0/self.scrollView.zoomScale, 1.0/self.scrollView.zoomScale);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
