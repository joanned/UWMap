//
//  SecondViewController.h
//  UWMap
//
//  Created by DEV FLOATER 119 on 10/1/14.
//  Copyright (c) 2014 Joanne Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuildingListViewControllerDelegate <NSObject>

- (void)backButtonTapped;

@end

@interface BuildingListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<BuildingListViewControllerDelegate> delegate;

@end
