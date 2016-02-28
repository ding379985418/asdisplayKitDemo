//
//  ViewController.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/25.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "ViewController.h"
#import "DXCustomCllNode.h"
#import "DXStatusModel.h"
#import "DXUserModel.h"
#import "DXStatusListViewModel.h"
@interface ViewController ()<ASTableViewDataSource,ASTableViewDelegate>

@property (nonatomic, strong) ASTableView *tableView;

@property (nonatomic, strong) DXStatusListViewModel *statusListViewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupUI];
}

- (void)setupUI{
    self.tableView = [[ASTableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.asyncDelegate = self;
    self.tableView.asyncDataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

- (void)loadData{
    [self.statusListViewModel loadStatusSince_id:0 max_id:0 complete:^(BOOL isSucess) {
        if (isSucess) {
            [self.tableView reloadData];
        }
    }];

}
#pragma mark -ASTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusListViewModel.statusList.count;
}

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath{

     DXCustomCllNode*cell = [[DXCustomCllNode alloc]init];
    
    cell.statusModel =  self.statusListViewModel.statusList[indexPath.row];

    return cell;
}


- (void)dealloc{
    self.tableView.asyncDataSource = nil;
    self.tableView.asyncDelegate = nil;

}
#pragma mark -懒加载

- (DXStatusListViewModel *)statusListViewModel{
    if (!_statusListViewModel) {
        _statusListViewModel = [[DXStatusListViewModel alloc]init];
    }
    return _statusListViewModel;

}

@end
