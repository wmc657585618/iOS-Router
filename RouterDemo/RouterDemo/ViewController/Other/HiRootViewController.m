//
//  HiRootViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRootViewController.h"
#import "HiRouterManager.h"
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
    NSArray *array = @[callBack,parametes,network,page];
    
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
            path = @"network/main";
            break;
        case HiRootTableModelTypePage:
            path = @"page/main";

            break;
        case HiRootTableModelTypeCallBack:
            path = @"callback/main";

            break;
        case HiRootTableModelTypeParametes:
            path = @"parametes/main";

            break;
    }
    [[HiRouter.instance build:path fromViewController:self action:HiRouterNavigationActionPush] buildAnimated:true completion:nil];
}

@end
