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
#import <FMMoveTableView/FMMoveTableView.h>
#import <FMMoveTableView/FMMoveTableViewCell.h>

@interface LeftSideDrawerViewController ()<FMMoveTableViewDataSource, FMMoveTableViewDelegate>
@property(nonatomic, strong)FMMoveTableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataSource;
@property(nonatomic, strong)UIButton *editingButton;
@end

@implementation LeftSideDrawerViewController
@synthesize tableView;
@synthesize dataSource;

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
    self.title = T(@"长按调整排序");
    
    self.editingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.editingButton.frame=CGRectMake(0, 0, 50, 29);
    [self.editingButton setTitle:T(@"排序") forState:UIControlStateNormal];
    [self.editingButton addTarget:self action:@selector(editingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.editingButton];
    
    
    CGRect frame = self.view.bounds;
    frame.size.width = LEFT_MAX_WIDTH;
    self.tableView = [[FMMoveTableView alloc]initWithFrame:frame style:UITableViewStylePlain];
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

- (NSInteger)numberOfSectionsInTableView:(FMMoveTableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(FMMoveTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

#pragma mark - tableview delegate

- (void)editingButtonAction
{
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:NO];
    }else{
        [self.tableView setEditing:YES animated:YES];
        
    }
}

- (void)moveTableView:(FMMoveTableView *)tableView moveRowFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    id thing = [self.dataSource objectAtIndex:fromIndexPath.row];
    [self.dataSource removeObjectAtIndex:fromIndexPath.row];
    [self.dataSource insertObject:thing atIndex:toIndexPath.row];   
}

//- (void)tableView:(FMMoveTableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    id thing = [self.dataSource objectAtIndex:sourceIndexPath.row];
//    [self.dataSource removeObjectAtIndex:sourceIndexPath.row];
//    [self.dataSource insertObject:thing atIndex:destinationIndexPath.row];
//    NSLog(@"%@",thing);
//}
- (BOOL)tableView:(FMMoveTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSIndexPath *)moveTableView:(FMMoveTableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	//	Uncomment these lines to enable moving a row just within it's current section
	//	if ([sourceIndexPath section] != [proposedDestinationIndexPath section]) {
	//		proposedDestinationIndexPath = sourceIndexPath;
	//	}
	
	return proposedDestinationIndexPath;
}

#pragma mark - FmmoveTableView


- (FMMoveTableViewCell *)tableView:(FMMoveTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeftDrawerCell";
    FMMoveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[FMMoveTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    Exchanger *rowData = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = rowData.name;
    
    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
