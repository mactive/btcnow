//
//  LeftSideDrawerViewController.m
//  btcnow
//
//  Created by meng qian on 14-1-2.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//

#import "LeftSideDrawerViewController.h"
#import "AppRequester.h"
#import "AppDelegate.h"

@interface LeftSideDrawerViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataSource;
@property(nonatomic, strong)NSArray *sectionArray;
@end

@implementation LeftSideDrawerViewController
@synthesize tableView;
@synthesize dataSource;
@synthesize sectionArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.sectionArray = [NSArray arrayWithObjects:@"交易所", @"帮助", @"关于", nil];
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initExchangers];
}

- (void)initExchangers
{
    [[AppRequester sharedManager]getExchangerInfoWithBlock:^(id responseObject, NSError *error) {
        if (responseObject != nil) {
            self.dataSource = [responseObject objectForKey:@"exchanger"];
            // reload data delegate
            // TODO remake cut some parameter
            XAppDelegate.exchangers = self.dataSource;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableview datashource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.dataSource count];
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSInteger section = indexPath.section;
    if (section == 0){
        NSDictionary *rowData = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = [rowData objectForKey:@"name"];
    }else{
        cell.textLabel.text = @"xxx";
    }

    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
