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
@property (weak, nonatomic) IBOutlet UIView *hoursView;

@end

@implementation FoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hoursView.layer.cornerRadius = 5.0f;
    self.hoursView.layer.masksToBounds = YES;
    
    self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.frame.size.width - 20;
    self.descriptionLabel.preferredMaxLayoutWidth = self.descriptionLabel.frame.size.width - 20;
    self.noticeLabel.preferredMaxLayoutWidth = self.noticeLabel.frame.size.width - 20;
//    self.headerView.layer.shadowColor = [[UIColor blackColor] CGColor]; //TODO: fix or remove
//    self.headerView.layer.shadowOpacity = 0.4f;
//    self.headerView.layer.shadowRadius = 5.5f;
//    self.headerView.layer.shadowOffset = CGSizeMake(0, 1.0f);
//    self.headerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.headerView.bounds].CGPath;
    
//    self.backgroundColor = [UIColor clearColor];
}

@end
