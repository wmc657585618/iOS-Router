//
//  HiRootViewController.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiRootViewController.h"

typedef NS_ENUM(NSUInteger, HiRootCellType) {
    HiRootCellType0,// 传值
    HiRootCellType1,// 回调
    HiRootCellType2,// 过滤
    HiRootCellType3,
    HiRootCellType4,
};

@interface HiRootCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) HiRootCellType type;

@end

@implementation HiRootCellModel

+ (instancetype)title:(NSString *)title type:(HiRootCellType)type detail:(NSString *)detail{
    HiRootCellModel *model = [[self alloc] init];
    model.title = title;
    model.type = type;
    model.detail = detail;
    return model;
}

@end

@interface HiRootViewController ()<UITableViewDelegate,UITableViewDataSource, HiNetWork>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<HiRootCellModel *> *dataSource;

@end

static NSString *const kCellId = @"UITableViewCell";

@implementation HiRootViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray<HiRootCellModel *> *)dataSource {
    if (!_dataSource) {
        HiRootCellModel *model0 = [HiRootCellModel title:@"传值" type:HiRootCellType0 detail:@"将 hello world 传到下个页面"];
        HiRootCellModel *model1 = [HiRootCellModel title:@"回调" type:HiRootCellType1 detail:@"收到下个页面 回调的 hello world"];
        HiRootCellModel *model2 = [HiRootCellModel title:@"过滤" type:HiRootCellType2 detail:@"过滤"];
        HiRootCellModel *model3 = [HiRootCellModel title:@"调用类方法" type:HiRootCellType3 detail:@"NSLog 输出"];
        HiRootCellModel *model4 = [HiRootCellModel title:@"实例化一个对象" type:HiRootCellType4 detail:@"NSLog 输出"];
        _dataSource = @[model0, model1, model2, model3, model4];
    }
    
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark *********** dataSource ***********
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellId];
    }
    
    HiRootCellModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detail;
    return cell;
}

#pragma mark *********** delegate ***********
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HiRootCellModel *model = self.dataSource[indexPath.row];

    switch (model.type) {
        case HiRootCellType0:
            [self hi_pushPath:parameters withInitParameters:@"hello world" animated:true];
            
            break;
        case HiRootCellType1:
        {
            id objc = [self hi_pushPath:callback withInitParameters:nil animated:true];
            // block
            [objc setHi_router_block:^id(id response) {
                NSLog(@"root 收到回调: %@",response);
                return @"收到回调: 你好, 世界";
            }];
            // delegate
//            [objc setHi_router_delegate:self];
        }

            break;
        case HiRootCellType2:
            [self hi_pushPath:filter withInitParameters:nil animated:true];

            break;
        case HiRootCellType3:
        {
            NSLog(@"%@",[@"class/method" hi_request:@"root 调用"]);
        }
            break;
        case HiRootCellType4:
        {
            // 实例方法
//            NSLog(@"实例化一个对象 %@",[self hi_objectForPath:@"class/init"]);
            // 类方法
            NSLog(@"实例化一个对象 %@",[NSObject hi_instanceForPath:@"class/init"]);
        }
            break;
    }
}

- (id)hi_response:(id)response {
    
    NSLog(@"root 收到回调: %@",response);
    return @"收到回调: 你好, 世界";
}

@end
