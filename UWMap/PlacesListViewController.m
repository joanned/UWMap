//
//  SecondViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "PlacesListViewController.h"

@interface PlacesListViewController ()

@property NSDictionary *locationDictionary;
@property NSArray *keys;

@end

@implementation PlacesListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.locationDictionary = @{
                                @"Arts Lecture Hall" : [NSValue valueWithCGPoint:CGPointMake(793, 694)],
                                @"Biology 1" : [NSValue valueWithCGPoint:CGPointMake(793, 529)],
                                @"Biology 2" : [NSValue valueWithCGPoint:CGPointMake(757, 500)],
                                @"B.C. Matthews Hall" : [NSValue valueWithCGPoint:CGPointMake(789, 251)],
                                };
    
    self.keys = [self.locationDictionary allKeys];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
