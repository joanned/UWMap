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

@interface BuildingListViewController ()


@property NSDictionary *locationDictionary;
@property NSArray *buildingsArray;
@property NSMutableArray *filteredArray;

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

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.filteredArray = [self.buildingsArray mutableCopy];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Building *building = [self.filteredArray objectAtIndex:indexPath.row];
    cell.textLabel.text = building.buildingName;
    
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
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"buildingName CONTAINS[cd] %@ OR shortform CONTAINS[cd] %@",searchText, searchText]; //tODO:shortform, change to array of objects intesad???
        
        self.filteredArray = [NSMutableArray arrayWithArray:[self.buildingsArray filteredArrayUsingPredicate:predicate]];
    }
}


- (void)reloadTableWithText:(NSString *)searchText {
    [self filterForSearchText:searchText];
    [self.tableView reloadData];
}

@end
