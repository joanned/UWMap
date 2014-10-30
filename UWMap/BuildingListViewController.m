//
//  SecondViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "BuildingListViewController.h"
#import "DataProvider.h"

@interface BuildingListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSDictionary *locationDictionary;
@property NSArray *keys;
@property NSMutableArray *filteredArray;

@end

@implementation BuildingListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationDictionary = [DataProvider buildingDictionary];
    self.keys = [self.locationDictionary allKeys];
    self.filteredArray = [self.keys mutableCopy];
    self.filteredArray = [NSMutableArray arrayWithCapacity:[self.keys count]];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.filteredArray = [self.keys mutableCopy];
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
    
    cell.textLabel.text = [self.filteredArray objectAtIndex:indexPath.row];
    
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
    if ([searchText isEqualToString:@""]) {
        self.filteredArray = [self.keys mutableCopy];
    } else {
        [self.filteredArray removeAllObjects];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
        
        self.filteredArray = [NSMutableArray arrayWithArray:[self.keys filteredArrayUsingPredicate:predicate]];
    }
}


- (void)reloadTableWithText:(NSString *)searchText {
    [self filterForSearchText:searchText];
    [self.tableView reloadData];
}

@end
