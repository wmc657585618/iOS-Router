//
//  HiRootViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRootViewController.h"
#import "HiRootTableModel.h"

@interface HiRootViewController ()<UITableViewDataSource,UITableViewDelegate,HiInit>

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
            path = network_main;
            break;
        case HiRootTableModelTypePage:
            path = page_main;
            
            break;
        case HiRootTableModelTypeCallBack:
            path = callback_main;

            break;
        case HiRootTableModelTypeParametes:
            path = parametes_main;

            break;
        case HiRootTableModelTypeViewModel:
            path = viewmodel;

            break;
        case HiRootTableModelTypeNavigation:
            path = nav_first;
            break;
    }

    [self hi_pushPath:path withInitParameters:nil request:nil animated:true];
}

+ (instancetype)hi_init:(id)parameters{
    return [[self alloc] init];
}

+ (void)hi_request:(id)request hi_response:(id (^)(id))response {
    NSLog(@"hi_request %@", request);
    if (response) {
        NSString *s = response(@"his is a response test");
        NSLog(@"%@",s);
    }
}

@end
