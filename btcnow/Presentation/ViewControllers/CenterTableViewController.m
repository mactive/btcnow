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
@property(nonatomic, strong)UIView *statsView;
@property(nonatomic, strong)UIView *headerView;
@end

@implementation CenterTableViewController
@synthesize tableView;
@synthesize dataSource;
@synthesize dataKeys;
@synthesize storedKeys;
@synthesize footerView;
@synthesize loopTimer;
@synthesize statsView, headerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define OFFSET_X 10
#define LABEL_ALL_W  (TOTAL_WIDTH - OFFSET_X * 2)
#define CELL_NAME_TAG 10
#define CELL_LAST_TAG 11
#define CELL_UPDOWN_TAG 12
#define CELL_VOL_TAG 13

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = GREENCOLOR;
    
    CGRect tableFrame  = self.view.bounds;
    tableFrame.size.width = LABEL_ALL_W;
    tableFrame.origin.x = OFFSET_X;
    tableFrame.origin.y = IOS7_CONTENT_OFFSET_Y;
    
    self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    self.title = T(@"BTCNow");
    
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    
    [self initStatsView];
    [self initHeaderView];
//    [self initFooterView];

}

- (void)refreshData
{
    [[AppRequester sharedManager]getTickerDataWithBlock:^(id responseObject, NSError *error) {
        //
        self.dataSource = [responseObject objectForKey:@"btc"];
        [self.tableView reloadData];
    }];
}


/*===================================================*/
#pragma mark - statsView header footer view
/*===================================================*/

- (void)initStatsView
{
    self.statsView = [[UIView alloc]initWithFrame:CGRectMake(OFFSET_X, IOS7_CONTENT_OFFSET_Y+OFFSET_X, LABEL_ALL_W, CELL_HEIGHT)];
//    self.statsView.layer.cornerRadius = OFFSET_X;
    self.statsView.layer.backgroundColor = [WHITECOLOR CGColor];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:self.statsView.bounds];
    label1.font = FONT_BOOK_12;
    label1.text = @"HashRate: 23445.56 GH/s";
    label1.textAlignment = NSTextAlignmentCenter;
    [self.statsView addSubview:label1];
    
    [self.view addSubview:self.statsView];
}


- (void)initHeaderView
{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LABEL_ALL_W, CELL_HEIGHT)];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(OFFSET_X, 0, LABEL_ALL_W / 3, CELL_HEIGHT)];
    label1.text = T(@"交易所");
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(LABEL_ALL_W / 3, 0, LABEL_ALL_W / 3, CELL_HEIGHT)];
    label2.text = T(@"最近成交价");
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(LABEL_ALL_W / 3*2, 0, LABEL_ALL_W / 3, CELL_HEIGHT)];
    label3.text = T(@"24h成交量(BTC)");
    
    label1.font = [UIFont systemFontOfSize:12.0f];
    label2.font = [UIFont systemFontOfSize:12.0f];
    label3.font = [UIFont systemFontOfSize:12.0f];
    label1.textAlignment = NSTextAlignmentLeft;
    label2.textAlignment = NSTextAlignmentLeft;
    label3.textAlignment = NSTextAlignmentLeft;
    
    [self.headerView addSubview:label1];
    [self.headerView addSubview:label2];
    [self.headerView addSubview:label3];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CELL_HEIGHT-1, LABEL_ALL_W, 1)];
    lineView.backgroundColor = GRAYLIGHTCOLOR;
    [self.headerView addSubview:lineView];
    
    self.headerView.backgroundColor = WHITECOLOR;
    self.tableView.tableHeaderView = self.headerView;
}



- (void)initFooterView
{
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TOTAL_WIDTH, CELL_HEIGHT)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:T(@"实时新闻") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(viewNewsAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(20, 10, 280, 40)];
    [self.footerView addSubview:button];
    self.tableView.tableFooterView = self.footerView;
}

- (void)viewNewsAction:(id)sender
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
                      scheduledTimerWithTimeInterval:(10.0)
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
    [rightDrawerButton setTitle:ICON_RSS forState:UIControlStateNormal];
    [rightDrawerButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [rightDrawerButton addTarget:self action:@selector(viewNewsAction:) forControlEvents:UIControlEventTouchUpInside];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}


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
    static NSString *CellIdentifier = @"ExchangerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;

}


- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(OFFSET_X, 0, 100, CELL_HEIGHT)];
    titleLabel.tag = CELL_NAME_TAG;
    titleLabel.font = FONT_BOLD_15;
    titleLabel.textColor = DARKCOLOR;
    
    UILabel *lastLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 70 ,CELL_HEIGHT)];
    lastLabel.tag = CELL_LAST_TAG;
    lastLabel.font = FONT_BOLD_15;
    lastLabel.textColor = DARKCOLOR;
    
    UILabel *updownLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 0, 20 ,CELL_HEIGHT)];
    updownLabel.font = FONT_AWESOME_15;
    updownLabel.tag = CELL_UPDOWN_TAG;
    updownLabel.textColor = GRAYCOLOR;
    
    UILabel *volLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 0, 80 ,CELL_HEIGHT)];
    volLabel.font = FONT_BOLD_15;
    volLabel.tag = CELL_VOL_TAG;
    volLabel.textColor = DARKCOLOR;
    
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:lastLabel];
    [cell.contentView addSubview:updownLabel];
    [cell.contentView addSubview:volLabel];
    
    return  cell;
}



- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    // two type
    NSDictionary *cellData = [self.dataSource objectForKey:[self.dataKeys objectAtIndex:indexPath.row]];
    
    if (cellData != nil) {
        NSDictionary *nowData = [cellData objectForKey:@"now"];
        
        //
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:CELL_NAME_TAG];
        titleLabel.text = [self.dataKeys objectAtIndex:indexPath.row];
        
        //
        UILabel *lastLabel = (UILabel *)[cell viewWithTag:CELL_LAST_TAG];
        NSNumber *lastNum = [nowData objectForKey:@"last"];
        
        NSString* currency = [cellData objectForKey:@"type"];
        if ([currency isEqualToString:@"us"]) {
            lastLabel.text = [NSString stringWithFormat:@"$ %@",lastNum.stringValue];
        }else if([currency isEqualToString:@"cny"]){
            lastLabel.text = [NSString stringWithFormat:@"¥ %@",lastNum.stringValue];
        }
        
        //
        UILabel *updownLabel = (UILabel *)[cell viewWithTag:CELL_UPDOWN_TAG];
        updownLabel.text = [self upOrDown:cellData];
        NSLog(@"upOrDown %@",updownLabel.text);
        if ([updownLabel.text isEqualToString:ICON_UP]) {
            updownLabel.textColor = GREENCOLOR;
        }else if([updownLabel.text isEqualToString:ICON_DOWN]){
            updownLabel.textColor = REDCOLOR;
        }else{
            updownLabel.textColor = GRAYCOLOR;
        }
        
        //
        UILabel *volLabel = (UILabel *)[cell viewWithTag:CELL_VOL_TAG];
        NSNumber *volNum = [nowData objectForKey:@"vol"];
        volLabel.text = volNum.stringValue;
        
    }
    

}



// YES UP / NO DOWN
- (NSString *)upOrDown:(NSDictionary *)item
{
    NSDictionary *lastDict = item[@"last"];
    NSDictionary *nowDict = item[@"now"];
    
    if (  nowDict[@"sell"] > lastDict[@"sell"] ) {
        return ICON_UP;
    }else if(nowDict[@"sell"] < lastDict[@"sell"]){
        return ICON_DOWN;
    }else{
        return ICON_IDLE;
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
    
    self.dataKeys = [DataTransformer sortArray:self.dataKeys withAsc:YES];
    
    [self.tableView reloadData];
}


#pragma mark - method function



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
