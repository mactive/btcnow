//
//  LeftSideDrawerViewController.h
//  btcnow
//
//  Created by meng qian on 14-1-2.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//

#import "SideDrawerViewController.h"
#import "PassValueDelegate.h"

@interface LeftSideDrawerViewController : SideDrawerViewController

@property(nonatomic,assign) NSObject<PassValueDelegate> *delegate;

@end
