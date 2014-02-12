//
//  CenterTableViewController.m
//  btcnow
//
//  Created by meng qian on 14-1-2.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//

#import "CenterTableViewController.h"
#import "AppRequester.h"
#import "AppDelegate.h"
#import "Exchanger.h"
#import "UIViewController+MMDrawerController.h"
#import "NewsListViewController.h"
#import "FMViewController.h"
#import "PassValueDelegate.h"


@interface CenterTableViewController ()<PassValueDelegate>
@property(nonatomic, strong)UIView *footerView;
@property(nonatomic, strong)NSMutableArray *storedKeys;
@property(nonatomic, strong)NSTimer *loopTimer;
@end

@implementation CenterTableViewController
@synthesize tableView;
@synthesize dataSource;
@synthesize dataKeys;
@synthesize storedKeys;
@synthesize footerView;
@synthesize loopTimer;

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
    
    self.view.backgroundColor = GREENCOLOR;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    self.title = T(@"BTCNow");
    
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    
    [self initFooterView];
}

- (void)refreshData
{
    [[AppRequester sharedManager]getTickerDataWithBlock:^(id responseObject, NSError *error) {
        //
        self.dataSource = [responseObject objectForKey:@"btc"];
        [self.tableView reloadData];
    }];
}

- (void)initFooterView
{
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TOTAL_WIDTH, CELL_HEIGHT)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:T(@"实时新闻") forState:UIControlStateNormal];
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

//TODO 10 seconds request once
//TODO remember the selected keys

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self refreshData];
    
    self.loopTimer = [NSTimer
                      scheduledTimerWithTimeInterval:(2.0)
                      target:self
                      selector:@selector(refreshData)
                      userInfo:nil
                      repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.loopTimer invalidate];
}


- (void)getExchangersWithSelected
{
    self.dataKeys = [[NSMutableArray alloc]init];

    NSArray *exchangers = XAppDelegate.exchangers;
    for (int i=0; i< [exchangers count]; i++) {
        Exchanger *theExchanger = [exchangers objectAtIndex:i];
        [self.dataKeys addObject:theExchanger.shortname];
    }
    
}


#pragma mark -- BarButton Item

-(void)setupLeftMenuButton{
    UIButton *leftDrawerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftDrawerButton.titleLabel.font = FONT_AWESOME_24;
    [leftDrawerButton setTitle:ICON_LIST forState:UIControlStateNormal];
    [leftDrawerButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [leftDrawerButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftDrawerButton setFrame:CGRectMake(0, 0, 50, 30)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftDrawerButton];
}

-(void)setupRightMenuButton{
    UIButton *rightDrawerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    rightDrawerButton.titleLabel.font = FONT_AWESOME_24;
    [rightDrawerButton setTitle:ICON_SETTING forState:UIControlStateNormal];
    [rightDrawerButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
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
    NSDictionary *nowData = [cellData objectForKey:@"now"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@  -  %@ %@ -  %@",
    [self.dataKeys objectAtIndex:indexPath.row], [nowData objectForKey:@"last"], [self upOrDown:cellData], [nowData objectForKey:@"vol"]];
    
    
    
    
    return cell;
}

// YES UP / NO DOWN
- (NSString *)upOrDown:(NSDictionary *)item
{
    NSDictionary *lastDict = item[@"last"];
    NSDictionary *nowDict = item[@"now"];
    
    if ( [(NSString *)nowDict[@"sell"] integerValue] > [(NSString *)lastDict[@"sell"] integerValue] ) {
        return @"↑";
    }else{
        return @"↓";
    }
}

- (void)passStringValue:(NSString *)value andIndex:(NSUInteger)index
{
    NSLog(@"PASS: %@",value);

    
    if ([value isEqualToString:@"SYNC_EXCHANGERS"]) {
        [self getExchangersWithSelected];
    }else{
        // 0 remove 1 add
        if (index == 0) {
            [self.dataKeys removeObject:value];
        }else if(index == 1){
            [self.dataKeys addObject:value];
        }
    }
    
    self.dataKeys = [self sortExchangers:self.dataKeys];
    
    [self.tableView reloadData];
}




- (NSMutableArray *)sortExchangers:(NSArray *)sourceArray
{
    NSMutableArray *sourceMutableArray = [[NSMutableArray alloc]initWithArray:sourceArray];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@""
                                                ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

    [sourceMutableArray sortUsingDescriptors:sortDescriptors];
    
    return sourceMutableArray;
}

// resort the exchangers array
// another way
//- (NSMutableArray *)sortExchangers:(NSArray *)sourceArray
//{
//    NSArray *sortedArray = [[NSArray alloc]init];
//
//
//    sortedArray = [sourceArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        NSString *first = obj1;
//        NSString *second = obj2;
//        return [first compare:second];
//    }];
//    return [[NSMutableArray alloc]initWithArray: sortedArray];
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
