//
//  FirstViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//
//@import UIKIt;
#import "MapViewController.h"

@interface MapViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.frame = CGRectMake(0, 0, [[UIImage imageNamed:@"mapImage.png"] size].width-50, [[UIImage imageNamed:@"mapImage.png"] size].height-50);
    [self.scrollView setClipsToBounds:YES];
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 6.0;
    self.scrollView.contentSize = CGSizeMake ([[UIImage imageNamed:@"mapImage.png"] size].width, [[UIImage imageNamed:@"mapImage.png"] size].height);
    self.scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
