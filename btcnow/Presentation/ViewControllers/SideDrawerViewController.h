//
//  SideDrawerViewController.h
//  btcnow
//
//  Created by meng qian on 14-1-2.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//
#import "BNViewController.h"
#import "UIViewController+MMDrawerController.h"

typedef NS_ENUM(NSInteger, MMDrawerSection){
    MMDrawerSectionViewSelection,
    MMDrawerSectionDrawerWidth,
    MMDrawerSectionShadowToggle,
    MMDrawerSectionOpenDrawerGestures,
    MMDrawerSectionCloseDrawerGestures,
    MMDrawerSectionCenterHiddenInteraction,
    MMDrawerSectionStretchDrawer,
};

@interface SideDrawerViewController : BNViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;

@end
