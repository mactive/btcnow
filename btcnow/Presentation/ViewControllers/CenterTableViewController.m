//
//  CenterTableViewController.m
//  btcnow
//
//  Created by meng qian on 14-1-2.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//

#import "CenterTableViewController.h"
#import "AppRequester.h"

#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "LeftSideDrawerViewController.h"
#import "RightSideDrawerViewController.h"
#import "BNNavigationController.h"
#import "NewsListViewController.h"
#import "FMViewController.h"

@interface CenterTableViewController ()
@property(nonatomic, strong)NSDictionary *dataSource;
@property(nonatomic, strong)NSArray *dataKeys;
@property(nonatomic, strong)UIView *footerView;
@end

@implementation CenterTableViewController
@synthesize tableView;
@synthesize dataSource;
@synthesize dataKeys;
@synthesize footerView;

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
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    self.title = T(@"BTCNow");
    
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    
    [self initFooterView];
}

- (void)initFooterView
{
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TOTAL_WIDTH, CELL_HEIGHT)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:T(@"浏览文章") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(viewNewsAction) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(20, 10, 280, 40)];
    [self.footerView addSubview:button];
    self.tableView.tableFooterView = self.footerView;
}

- (void)viewNewsAction
{
    NewsListViewController *viewController = [[NewsListViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[AppRequester sharedManager]getTickerDataWithBlock:^(id responseObject, NSError *error) {
        //
        NSLog(@"%@",responseObject);
        self.dataSource = [responseObject objectForKey:@"exchangers"];
        self.dataKeys = [self.dataSource allKeys];
        [self.tableView reloadData];
    }];
}


#pragma mark -- BarButton Item

-(void)setupLeftMenuButton{
    UIButton *leftDrawerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftDrawerButton.titleLabel.font = FONT_AWESOME_24;
    [leftDrawerButton setTitle:ICON_LIST forState:UIControlStateNormal];
    [leftDrawerButton setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    [leftDrawerButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftDrawerButton setFrame:CGRectMake(0, 0, 50, 30)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftDrawerButton];
}

-(void)setupRightMenuButton{
    UIButton *rightDrawerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    rightDrawerButton.titleLabel.font = FONT_AWESOME_24;
    [rightDrawerButton setTitle:ICON_SETTING forState:UIControlStateNormal];
    [rightDrawerButton setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    [rightDrawerButton addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [rightDrawerButton setFrame:CGRectMake(0, 0, 50, 30)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightDrawerButton];
}


#pragma mark -- actions

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

#pragma mark -- tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataKeys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *cellData = [self.dataSource objectForKey:[self.dataKeys objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = [self.dataKeys objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"last %@ high %@ ",[cellData objectForKey:@"last"],[cellData objectForKey:@"high"]];
    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
