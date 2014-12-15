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
@property (weak, nonatomic) IBOutlet UIView *maskView;


@end

@implementation FoodDetailsView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.backgroundColor = [UIColor colorWithRed:43.0f/255 green:43.0f/255 blue:43.0f/255 alpha:0.8f];

    [self bringSubviewToFront:self.closeButton];
}

-(void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self adjustHeightOfTableview];
}

- (IBAction)closeButtonTapped:(id)sender {
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    if ([self.delegate respondsToSelector:@selector(foodDetailsCloseButtonTapped)]) {
        [self.delegate foodDetailsCloseButtonTapped];
    }
}

- (void)setupDataWithFoodData:(NSMutableArray *)foodDataArray {
    self.foodDataArray = foodDataArray;
    [self.tableView reloadData];
}

- (void)setupGradientMask {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = @[(id)[[UIColor clearColor] CGColor], (id)[[UIColor whiteColor] CGColor], (id)[[UIColor whiteColor] CGColor], (id)[[UIColor clearColor] CGColor]];
    gradient.locations = @[@0.0, @0.03, @0.9, @1.0];
    self.maskView.layer.mask = gradient;
}

- (void)setupShadows {
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.8f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void)adjustHeightOfTableview {
    CGFloat maxHeight = [[UIScreen mainScreen] bounds].size.height - 84 - 20;//todo:change numbers to something dynamic v__ v ~~~
    CGFloat height = MIN(self.tableView.contentSize.height, maxHeight);

    if ([self.delegate respondsToSelector:@selector(updateTableViewHeight:)]) {
        [self.delegate updateTableViewHeight:height];
    }
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
//    [self setupShadowsWithFrame:sizingCell.bounds];
    [self configureCell:sizingCell atIndexPath:indexPath];
    
    [sizingCell setNeedsUpdateConstraints];
    [sizingCell updateConstraintsIfNeeded];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGFloat height = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height
    
    + 1.0f;
    
    return height;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}

#pragma mark - Helpers

- (void)configureCell:(FoodCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    FoodData *foodData = [self.foodDataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = foodData.title;
    cell.descriptionLabel.text = foodData.foodDescription;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
