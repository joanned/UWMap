//
//  SecondViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "BuildingListViewController.h"
#import "DataProvider.h"
#import "Building.h"
#import "FoodDataFetcher.h" //TODO: needed??
#import "FoodData.h"

@interface BuildingListViewController () <FoodDataFetcherDelegate>

//TODO: prob dont need to store dictionaries everywhere zz
@property (nonatomic, strong) NSDictionary *foodDictionary;
@property NSArray *foodTitlesArray;
@property NSDictionary *locationDictionary;
@property NSArray *buildingsArray; //TODO: nonatimc
@property NSMutableArray *filteredArray;



@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *buildingButton;

@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) UIColor *unhighlightedColor;

@property (nonatomic, assign) BOOL isShowingBuildings;

@end

@implementation BuildingListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0); //TODO: change 50 to dynamic number
    
    self.locationDictionary = [DataProvider buildingDictionary];
    self.buildingsArray = [self.locationDictionary allValues];
    
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"buildingName" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
    NSArray *sortedArray = [self.buildingsArray sortedArrayUsingDescriptors:descriptors];
    
    self.buildingsArray = sortedArray;
    
    self.whiteLayer.alpha = 0;
    
    [self setupButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.filteredArray = [self.buildingsArray mutableCopy];
}

#pragma mark - Button stuff

- (void)setupButtons {
    self.highlightedColor = [UIColor colorWithRed:52.0f/255 green:52.0f/255 blue:52.0f/255 alpha:1];
    self.unhighlightedColor = [UIColor colorWithRed:40.0f/255 green:40.0f/255 blue:40.0f/255 alpha:1];
    
    self.buildingButton.backgroundColor = self.unhighlightedColor;
    self.foodButton.backgroundColor = self.highlightedColor;
    self.isShowingBuildings = YES;
}

- (IBAction)foodButtonTapped:(id)sender {
    if (self.isShowingBuildings == YES) {
        self.isShowingBuildings = NO;
        self.buildingButton.backgroundColor = self.unhighlightedColor;
        self.foodButton.backgroundColor = self.highlightedColor;
        [self.tableView reloadData];
    }
}

- (IBAction)buildingButtonTapped:(id)sender {
    if (self.isShowingBuildings == NO) {
        self.isShowingBuildings = YES;
        self.buildingButton.backgroundColor = self.highlightedColor;
        self.foodButton.backgroundColor = self.unhighlightedColor;
        [self.tableView reloadData];
    }
}

- (void)foodDictionaryLoaded:(NSDictionary *)foodDictionary {
    self.foodDictionary = foodDictionary;
    self.foodTitlesArray = [foodDictionary allValues];
    
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
    self.foodTitlesArray = [self.foodTitlesArray sortedArrayUsingDescriptors:descriptors];
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isShowingBuildings) {
        return [self.filteredArray count];
    } else {
        return [self.foodTitlesArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (self.isShowingBuildings == YES) {
        Building *building = [self.filteredArray objectAtIndex:indexPath.row];
        cell.textLabel.text = building.buildingName;
    } else {
        FoodData *foodData = [self.foodTitlesArray objectAtIndex:indexPath.row];
        cell.textLabel.text = foodData.title;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *label = cell.textLabel.text;
    
    if ([self.delegate respondsToSelector:@selector(selectedCellWithLabel:)]) {
        [self.delegate selectedCellWithLabel:label];
    }
}

#pragma mark Content Filtering

-(void)filterForSearchText:(NSString*)searchText {
    if ([searchText isEqualToString:@""]) { //not needed this if else
        self.filteredArray = [self.buildingsArray mutableCopy];

    } else {
        [self.filteredArray removeAllObjects];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"buildingName CONTAINS[cd] %@ OR shortform BEGINSWITH[cd] %@",searchText, searchText];
        
        self.filteredArray = [NSMutableArray arrayWithArray:[self.buildingsArray filteredArrayUsingPredicate:predicate]];
    }
}


- (void)reloadTableWithText:(NSString *)searchText {
    [self filterForSearchText:searchText];
    [self.tableView reloadData];
}

@end
