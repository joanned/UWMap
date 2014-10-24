//
//  SecondViewController.m
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import "BuildingListViewController.h"

@interface BuildingListViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *backButton;

@end

@implementation BuildingListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tappedBuildingIcon:)];
    [self.backButton addGestureRecognizer:singleTap];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tappedBuildingIcon:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(backButtonTapped)]) {
        [self.delegate backButtonTapped];
    }
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.keys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.keys objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *label = cell.textLabel.text;

    if ([self.delegate respondsToSelector:@selector(selectedCellWithLabel:)]) {
        [self.delegate selectedCellWithLabel:label];
    }
}



@end
