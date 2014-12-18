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
- (void)dismissKeyboard;
- (void)reloadFoodData;

@end

@interface BuildingListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *blurredImageView;
@property (weak, nonatomic) IBOutlet UIView *whiteLayer;
@property (nonatomic, weak) id<BuildingListViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL showCombinedList;
@property (nonatomic, assign) BOOL failedToLoadFood;
@property (nonatomic, assign) BOOL isShowingBuildings;

- (void)reloadTableWithText:(NSString *)searchText showFullList:(BOOL)showFullList;
- (void)foodDictionaryLoaded:(NSDictionary *)foodDictionary;
- (void)foodLoadingFailed;

@end
