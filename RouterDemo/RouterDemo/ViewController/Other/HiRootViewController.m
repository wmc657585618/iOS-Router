//
//  HiRootViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRootViewController.h"
#import "HiRouterManager.h"

@interface HiRootViewController ()<UITableViewDataSource,UITableViewDelegate,HiRouterPageProtocol>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray *dataSource;

@end

static NSString *const cellID = @"HiRootViewController";
@implementation HiRootViewController

- (UITableView *)tableView {
 
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellID];
    self.tableView.dataSource = self;
    
    NSArray *array = @[@"registNetworkFilter",@"registPageFilter",@"postParametes",@"getCallBack",@"postAndCallBack"];
    
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
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[HiRouter.instance build:@"network/main" fromViewController:self action:HiRouterNavigationActionPush] buildAnimated:true completion:nil];
//    [[HiRouter.instance build:@"callback/main" fromViewController:self action:HiRouterNavigationActionPush] buildAnimated:true completion:nil];
//    [[HiRouter.instance build:@"parametes/main" fromViewController:self action:HiRouterNavigationActionPush] buildAnimated:true completion:nil];
}

@end
