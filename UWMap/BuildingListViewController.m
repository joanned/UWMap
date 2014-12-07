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
@property NSMutableArray *foodFilteredArray;

@property NSDictionary *locationDictionary;
@property NSArray *buildingsArray; //TODO: nonatimc
@property NSMutableArray *filteredArray;

@property NSArray *allLocationsArray;
@property NSMutableArray *allLocationsFilteredArray;

@property (weak, nonatomic) IBOutlet UIButton *buildingButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;

@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) UIColor *unhighlightedColor;

@property (nonatomic, assign) BOOL isShowingBuildings;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalSpaceBetweenButtonAndTable;

@end

@implementation BuildingListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0); //TODO: change 50 to dynamic number
    
    self.locationDictionary = [DataProvider buildingDictionary];
    self.buildingsArray = [self.locationDictionary allValues];
    
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
    NSArray *sortedArray = [self.buildingsArray sortedArrayUsingDescriptors:descriptors];
    
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    self.buildingsArray = sortedArray;
    
    self.whiteLayer.alpha = 0;
    
    [self setupButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.showCombinedList) {
        self.foodButton.hidden = YES;
        self.buildingButton.hidden = YES;
        self.horizontalSpaceBetweenButtonAndTable.constant = -self.buildingButton.frame.size.height;
    } else {
        self.foodButton.hidden = NO;
        self.buildingButton.hidden = NO;
        self.horizontalSpaceBetweenButtonAndTable.constant = 0;
    }
    
    self.filteredArray = [self.buildingsArray mutableCopy];
    self.foodFilteredArray = [self.foodTitlesArray mutableCopy];
}

#pragma mark - Button stuff

- (void)setupButtons {
    self.highlightedColor = [UIColor colorWithRed:52.0f/255 green:52.0f/255 blue:52.0f/255 alpha:1];
    self.unhighlightedColor = [UIColor colorWithRed:40.0f/255 green:40.0f/255 blue:40.0f/255 alpha:1];
    
    self.buildingButton.backgroundColor = self.highlightedColor;
    self.foodButton.backgroundColor = self.unhighlightedColor;
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
    self.foodTitlesArray = [foodDictionary allValues]; //TODO::needed?
    
    self.allLocationsArray = [self.foodTitlesArray arrayByAddingObjectsFromArray:self.buildingsArray];
    self.allLocationsFilteredArray = [self.allLocationsArray mutableCopy]; //TODO: needed?
    
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
    self.foodTitlesArray = [self.foodTitlesArray sortedArrayUsingDescriptors:descriptors];
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.showCombinedList) {
        return [self.allLocationsFilteredArray count];
    } else {
        if (self.isShowingBuildings) {
            return [self.filteredArray count];
        } else {
            return [self.foodFilteredArray count];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (self.showCombinedList) {
        if ([[self.allLocationsFilteredArray objectAtIndex:indexPath.row] isKindOfClass:[Building class]]) {
            Building *building = [self.allLocationsFilteredArray objectAtIndex:indexPath.row];
            cell.textLabel.text = building.title;
        } else {
            FoodData *foodData = [self.allLocationsFilteredArray objectAtIndex:indexPath.row];
            cell.textLabel.text = foodData.title;
        }
    } else {
        if (self.isShowingBuildings == YES) {
            Building *building = [self.filteredArray objectAtIndex:indexPath.row];
            cell.textLabel.text = building.title;
        } else {
            FoodData *foodData = [self.foodFilteredArray objectAtIndex:indexPath.row];
            cell.textLabel.text = foodData.title;
        }
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(dismissKeyboard)]) {
        [self.delegate dismissKeyboard];
    }
}

#pragma mark Content Filtering

-(void)filterForSearchText:(NSString*)searchText showFullList:(BOOL)showFullList {
    if ([searchText isEqualToString:@""]) { //not needed this if else
        if (self.isShowingBuildings) { //TODO: case when theres no foods
            self.filteredArray = [self.buildingsArray mutableCopy];
        } else {
            self.foodFilteredArray = [self.foodTitlesArray mutableCopy];
        }

    } else {
        if (showFullList && self.foodDictionary != nil) { //TODO: do more checks like this
            [self.allLocationsFilteredArray removeAllObjects];
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                if ([evaluatedObject isKindOfClass:[Building class]]) {
                    Building *building = (Building *)evaluatedObject;
                    if ([building.title rangeOfString:searchText].location != NSNotFound || [[building.shortform lowercaseString] hasPrefix:[searchText lowercaseString]]) {
                        return YES;
                    } else {
                        return NO;
                    }
                } else {
                    FoodData *foodData = (FoodData *)evaluatedObject;
                    if ([foodData.title rangeOfString:searchText].location != NSNotFound) {
                        return YES;
                    } else {
                        return NO;
                    }
                }
            }];
            
            self.allLocationsFilteredArray = [NSMutableArray arrayWithArray:[self.allLocationsArray filteredArrayUsingPredicate:predicate]];
            
        } else {
            if (self.isShowingBuildings) {
                [self.filteredArray removeAllObjects];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@ OR shortform BEGINSWITH[cd] %@",searchText, searchText];
                
                self.filteredArray = [NSMutableArray arrayWithArray:[self.buildingsArray filteredArrayUsingPredicate:predicate]];
            } else {
                [self.foodFilteredArray removeAllObjects];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",searchText];
                
                self.foodFilteredArray = [NSMutableArray arrayWithArray:[self.foodTitlesArray filteredArrayUsingPredicate:predicate]];
            }
        }
    }
}


- (void)reloadTableWithText:(NSString *)searchText showFullList:(BOOL)showFullList{
    [self filterForSearchText:searchText showFullList:showFullList];
    self.showCombinedList = showFullList;
    [self.tableView reloadData];
}

@end
