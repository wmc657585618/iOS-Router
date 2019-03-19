//
//  HiRootViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRootViewController.h"
#import "HiRootTableModel.h"

@interface HiRootViewController ()<UITableViewDataSource,UITableViewDelegate,HiRouterPageProtocol>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray *dataSource;

@end

static NSString *const cellID = @"HiRootViewController";
@implementation HiRootViewController

- (UITableView *)tableView {
 
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellID];
    self.tableView.dataSource = self;
    
    HiRootTableModel *callBack = [[HiRootTableModel alloc] initWithTitle:@"push to call back" type:HiRootTableModelTypeCallBack];
    HiRootTableModel *parametes = [[HiRootTableModel alloc] initWithTitle:@"push to parametes" type:HiRootTableModelTypeParametes];
    HiRootTableModel *network = [[HiRootTableModel alloc] initWithTitle:@"push to network" type:HiRootTableModelTypeNetwork];
    HiRootTableModel *page = [[HiRootTableModel alloc] initWithTitle:@"push to page" type:HiRootTableModelTypePage];
    HiRootTableModel *viewModel = [[HiRootTableModel alloc] initWithTitle:@"push to view model" type:HiRootTableModelTypeViewModel];
    HiRootTableModel *navigation = [[HiRootTableModel alloc] initWithTitle:@"push to nav" type:HiRootTableModelTypeNavigation];
    NSArray *array = @[callBack,parametes,network,page,viewModel,navigation];
    
    self.dataSource = array;
    
    self.tableView.delegate = self;
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    HiRootTableModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HiRootTableModel *model = self.dataSource[indexPath.row];

    NSString *path = @"";
    
    switch (model.type) {
        case HiRootTableModelTypeNetwork:
            path = NETWORK_MAIN;
            break;
        case HiRootTableModelTypePage:
            path = PAGE_MAIN;

            break;
        case HiRootTableModelTypeCallBack:
            path = CALLBACK_MAIN;

            break;
        case HiRootTableModelTypeParametes:
            path = PARAMETES_MAIN;

            break;
        case HiRootTableModelTypeViewModel:
            path = VIEWMODEL;

            break;
        case HiRootTableModelTypeNavigation:
            path = NAV_FIRST;
            break;
    }

    [self hi_pushPath:path animated:true];
}

@end
