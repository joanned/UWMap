//
//  SecondViewController.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuildingListViewControllerDelegate <NSObject>

- (void)selectedCellWithLabel:(NSString *)label;


@end

@interface BuildingListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *blurredImageView;
@property (nonatomic, weak) id<BuildingListViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (void)reloadTableWithText:(NSString *)searchText;

@end
