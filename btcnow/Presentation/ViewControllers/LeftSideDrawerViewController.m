//
//  LeftSideDrawerViewController.m
//  btcnow
//
//  Created by meng qian on 14-1-2.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LeftSideDrawerViewController.h"
#import "AppRequester.h"
#import "AppDelegate.h"
#import "ModelHelper.h"

@interface LeftSideDrawerViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataSource;
@property(nonatomic, strong)UIButton *editingButton;
@end

@implementation LeftSideDrawerViewController
@synthesize tableView;
@synthesize dataSource;
@synthesize delegate;

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
    self.title = T(@"交易所管理(点击关闭)");
    
//    self.editingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.editingButton.frame=CGRectMake(0, 0, 50, 29);
//    [self.editingButton setTitle:T(@"排序") forState:UIControlStateNormal];
//    [self.editingButton addTarget:self action:@selector(editingButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.editingButton];
    
    
    CGRect frame = self.view.bounds;
    frame.size.width = LEFT_MAX_WIDTH;
    self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshExchangers];
}

- (void)refreshExchangers
{
    self.dataSource = [[NSMutableArray alloc]initWithArray: XAppDelegate.exchangers];
    [self.tableView reloadData];
}

#pragma mark - tableview datashource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}



#pragma mark - UITableView


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeftDrawerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    
    return cell;
}

#define SEL_WIDTH 40.0
#define SEL_HEIGHT 20.0
#define SEL_Y (CELL_HEIGHT - SEL_HEIGHT)/2
#define SEL_TAG 10

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    UILabel *selectedLabal = [[UILabel alloc]initWithFrame:CGRectMake(LEFT_MAX_WIDTH - SEL_WIDTH, SEL_Y, SEL_WIDTH, SEL_HEIGHT)];
    selectedLabal.tag = SEL_TAG;
    selectedLabal.font = FONT_AWESOME_15;
    selectedLabal.text = ICON_CHECK;
    
    [cell.contentView addSubview:selectedLabal];
    
//    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    cell.textLabel.textColor = RGBCOLOR(195, 70, 21);
//    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return  cell;
}



- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    Exchanger *theExchanger = [self.dataSource objectAtIndex:indexPath.row];
    UILabel *selectedLabal = (UILabel *)[cell viewWithTag:SEL_TAG];
    
    if (theExchanger.selected) {
        [selectedLabal setHidden:NO];
    }else{
        [selectedLabal setHidden:YES];
    }
    
    cell.textLabel.text = theExchanger.name;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Exchanger *theExchanger = [self.dataSource objectAtIndex:indexPath.row];
    if (theExchanger.selected) {
        [self.delegate passStringValue:theExchanger.shortname andIndex:0];
    }else{
        [self.delegate passStringValue:theExchanger.shortname andIndex:1];
    }
    theExchanger.selected = !theExchanger.selected;

    
    [self.tableView beginUpdates];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
