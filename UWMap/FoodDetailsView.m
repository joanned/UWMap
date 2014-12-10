//
//  FoodDetails.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 12/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "FoodDetailsView.h"
#import "FoodCell.h"

@interface FoodDetailsView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *foodDataArray;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;



@end

@implementation FoodDetailsView

- (void)awakeFromNib {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self bringSubviewToFront:self.closeButton];
}

- (IBAction)closeButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(foodDetailsCloseButtonTapped)]) {
        [self.delegate foodDetailsCloseButtonTapped];
    }
}

- (void)setupDataWithFoodData:(NSMutableArray *)foodDataArray {
    self.foodDataArray = foodDataArray;
    [self.tableView reloadData];
}

- (void)setupShadowsForFoodDetails {
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.8f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeMake(0, 3.0f);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark <UITableViewDataSource, UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"FoodCell";
    
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    ///TODO: image and others
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.foodDataArray count];
}
//////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static FoodCell *sizingCell = nil;
    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"FoodCell"];
        if (sizingCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:self options:nil];
            sizingCell = [nib objectAtIndex:0];
        }
//    });
    
    [self configureCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
//    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizingCell.frame.size.height + 1.0f; // Add 1.0f for the cell separator height
}

#pragma mark - Helpers

- (void)configureCell:(FoodCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    FoodData *foodData = [self.foodDataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = foodData.title;
    cell.descriptionLabel.text = foodData.foodDescription;
    
    NSString *closedString = @"Closed";
    NSString *mondayHours = nil;
    NSString *tuesdayHours = nil;
    NSString *wednesdayHours = nil;
    NSString *thursdayHours = nil;
    NSString *fridayHours = nil;
    NSString *saturdayHours = nil;
    NSString *sundayHours = nil;
    
    if (foodData.mondayOpen != nil && foodData.tuesdayClose != nil) {
        mondayHours = [NSString stringWithFormat:@"%@ - %@", foodData.mondayOpen, foodData.mondayClose];
    } else {
        mondayHours = closedString;
    }
    
    if (foodData.tuesdayOpen != nil && foodData.tuesdayClose != nil) {
        tuesdayHours = [NSString stringWithFormat:@"%@ - %@", foodData.tuesdayOpen, foodData.tuesdayClose];
    } else {
        tuesdayHours = closedString;
    }
    
    if (foodData.wednesdayOpen != nil && foodData.wednesdayClose != nil) {
        wednesdayHours = [NSString stringWithFormat:@"%@ - %@", foodData.wednesdayOpen, foodData.wednesdayClose];
    } else {
        wednesdayHours = closedString;
    }
    
    if (foodData.thursdayOpen != nil && foodData.thursdayClose != nil) {
        thursdayHours = [NSString stringWithFormat:@"%@ - %@", foodData.thursdayOpen, foodData.thursdayClose];
    } else {
        thursdayHours = closedString;
    }
    
    if (foodData.fridayOpen != nil && foodData.fridayClose != nil) {
        fridayHours = [NSString stringWithFormat:@"%@ - %@", foodData.fridayOpen, foodData.fridayClose];
    } else {
        fridayHours = closedString;
    }
    
    if (foodData.saturdayOpen != nil && foodData.saturdayClose != nil) {
        saturdayHours = [NSString stringWithFormat:@"%@ - %@", foodData.saturdayOpen, foodData.saturdayClose];
    } else {
        saturdayHours = closedString;
    }
    
    if (foodData.sundayOpen != nil && foodData.sundayClose != nil) {
        sundayHours = [NSString stringWithFormat:@"%@ - %@", foodData.sundayOpen, foodData.sundayClose];
    } else {
        sundayHours = closedString;
    }
    
    cell.mondayLabel.text = mondayHours;
    cell.tuesdayLabel.text = tuesdayHours;
    cell.wednesdayLabel.text = wednesdayHours;
    cell.thursdayLabel.text = thursdayHours;
    cell.fridayLabel.text = fridayHours;
    cell.saturdayLabel.text = saturdayHours;
    cell.sundayLabel.text = sundayHours;
}

@end
