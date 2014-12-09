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



@end

@implementation FoodDetailsView

- (void)awakeFromNib {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (IBAction)closeButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(foodDetailsCloseButtonTapped)]) {
        [self.delegate foodDetailsCloseButtonTapped];
    }
}

- (void)setupDataWithFoodData:(NSMutableArray *)foodDataArray {
    self.foodDataArray = foodDataArray;
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
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"FoodCell"];
        if (sizingCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:self options:nil];
            sizingCell = [nib objectAtIndex:0];
        }
    });
    
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
}

@end
