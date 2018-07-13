//
//  MeViewController.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "MeViewController.h"

#import "HiRouter.h"

#import "MeTableViewCell.h"

#import "MeTableViewCellModel.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray<MeTableViewCellModel *> *dataSource;

@property (strong, nonatomic) HiRouterVMBuilderGroup *builderGroup;

@property (strong, nonatomic) HiRouterVMBuilder *vmBuilder;

@end

static NSString * const CellID = @"MeViewController";

@implementation MeViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        
        _tableView.rowHeight = 110;
        
        [_tableView registerClass:MeTableViewCell.class forCellReuseIdentifier:CellID];
    }
    
    return _tableView;
}

- (HiRouterVMBuilderGroup *)builderGroup {
    
    if (!_builderGroup) {
        
        _builderGroup = [[HiRouterVMBuilderGroup alloc] init];
    }
    
    return _builderGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:174 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    
    self.tableView.frame = self.view.bounds;
    
    [self.view addSubview:self.tableView];
    
    
    NSMutableArray *mArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 30; i ++) {
        
        NSString *name = [[NSString alloc] initWithFormat:@"name - %02ld",i];
        
        NSString *password = [[NSString alloc] initWithFormat:@"password - %02ld",i];
        
        MeTableViewCellModel *model = [[MeTableViewCellModel alloc] init];
        
        model.name = name;
        
        model.password = password;
        
        [mArray addObject:model];
    }
    
    self.dataSource = mArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:true];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    MeTableViewCell *meCell = (MeTableViewCell *)cell;
    
    NSString *key = [[NSString alloc] initWithFormat:@"cell%02ld",indexPath.row];
    
    HiRouterVMBuilder *builder = [self.builderGroup vmBuilderForKey:key];
    
    MeTableViewCellModel *model = self.dataSource[indexPath.row];
    
    if (builder) {
        
        [HiRouter.instance updateVMBuilder:builder objectA:meCell objectB:model];
        
    } else {
        
        [HiRouter.instance buildViewModeGrouplInDynamic:meCell objectB:model reuseIdentifier:key group:self.builderGroup];
    }
    
    [model doAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
