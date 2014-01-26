//
//  NewsListViewController.m
//  btcnow
//
//  Created by Mactive on 1/22/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "NewsListViewController.h"
#import "SVPullToRefresh.h"
#import "WebViewController.h"
#import "ArticleTableViewCell.h"
#import "AppRequester.h"

@interface NewsListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, assign)NSInteger start;


@end

@implementation NewsListViewController

@synthesize tableView = tableView;
@synthesize dataSource;
@synthesize start;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = T(@"比特币新闻");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = BGCOLOR;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = BGCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = SEPCOLOR;
    
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UIEdgeInsets currentInset = self.tableView.contentInset;
    
    // Manully set contentInset.
    if (OSVersionIsAtLeastiOS7()) {
        currentInset.top = self.navigationController.navigationBar.bounds.size.height;
        self.automaticallyAdjustsScrollViewInsets = NO;
        // On iOS7, you need plus the height of status bar.
        currentInset.top += STATUS_BAR_HEIGHT;
    }else{
        NSLog(@"ios 6");
        currentInset.bottom += TABBAR_HEIGHT;
    }
    self.tableView.contentInset = currentInset;
    
    
    
    [self.view addSubview:self.tableView];
    
    
    self.start = 0;
    
    [self setupDataSource];
    
    __weak NewsListViewController *weakSelf = self;
    
    //    self.tableView
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshTable];
    }];
    
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getMoreData];
    }];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    [self.tableView triggerPullToRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network Actions

- (void)setupDataSource {
    
    [[AppRequester sharedManager]getNewsWithStrat:0 length:20 andBlock:^(id responseObject, NSError *error) {
        if (responseObject) {
                // TODO 拿到数据之后再初始化
                // TODO stopAmimating 的时候自己 reload 了
                self.dataSource = [[NSMutableArray alloc] init];
                self.start = 0;
                
                self.dataSource = [NSMutableArray arrayWithArray:responseObject];
                self.start = [self.dataSource count];
                [self.tableView reloadData];
                NSLog(@"start %i", self.start);
        }
    }];
}


#pragma mark - append more

- (void)getMoreDataWithBlock:(void (^)(id responseObject, NSError *error))block
{
    
    [[AppRequester sharedManager]getNewsWithStrat:self.start length:20 andBlock:^(id responseObject, NSError *error) {
        if (responseObject) {
                // TODO 拿到数据之后再初始化
                // TODO stopAmimating 的时候自己 reload 了
                NSArray *resultArray = [[NSArray alloc]init];
                resultArray = responseObject;
                self.start =  self.start + [resultArray count];
                NSLog(@"start %i", self.start);
                
                if (block) {
                    block(resultArray, nil);
                }
        }else{
            if (block) {
                block(nil, error);
            }
        }
    }];
}

- (void)refreshTable
{
    __weak NewsListViewController *weakSelf = self;
    [weakSelf.tableView.pullToRefreshView setTitle:T(@">_< 努力加载中..") forState:SVPullToRefreshStateAll];
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self setupDataSource];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    });
}

- (void)getMoreData {
    __weak NewsListViewController *weakSelf = self;
    
    // custom loading style
    //    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    //    bottomLabel.text = T(@"显示更多20条");
    //    [weakSelf.tableView.infiniteScrollingView setCustomView:bottomLabel forState:SVInfiniteScrollingStateAll];
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        
        [self getMoreDataWithBlock:^(id responseObject, NSError *error) {
            //
            if (responseObject != nil) {
                for (NSDictionary *object in responseObject) {
                    [weakSelf.dataSource addObject:object];
                    [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
                }
            }
        }];
        
        [weakSelf.tableView endUpdates];
        
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    });
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TopCell";
    
    NSDictionary *cellData = [self.dataSource objectAtIndex:indexPath.row];
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell setNewData:cellData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *viewController = [[WebViewController alloc]initWithNibName:nil bundle:nil];
    NSDictionary *cellData = [self.dataSource objectAtIndex:indexPath.row];
    
    viewController.urlString = [cellData objectForKey:@"url"];
    [self.navigationController pushViewController:viewController animated:YES];
    
}


@end
