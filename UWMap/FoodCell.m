//
//  foodCell.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/8/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "FoodCell.h"

@interface FoodCell ()

@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation FoodCell

- (void)awakeFromNib {
    self.headerView.layer.shadowColor = [[UIColor blackColor] CGColor]; //TODO: fix or remove
    self.headerView.layer.shadowOpacity = 0.4f;
    self.headerView.layer.shadowRadius = 2.5f;
    self.headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    self.headerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.headerView.bounds].CGPath;
    
//    self.backgroundColor = [UIColor clearColor];
}

@end
