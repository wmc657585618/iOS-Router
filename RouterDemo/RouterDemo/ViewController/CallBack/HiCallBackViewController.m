//
//  HiCallBackViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiCallBackViewController.h"
#import "HiRouterManager.h"

@interface HiCallBackViewController ()
@property (nonatomic,strong) UILabel *receiveLabel;

@end

@Router(callback/main,HiCallBackViewController)
@implementation HiCallBackViewController

- (UILabel *)receiveLabel {
    
    if (!_receiveLabel) {
        _receiveLabel = [[UILabel alloc] init];
    }
    return _receiveLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat x = 20;
    CGFloat width = self.view.frame.size.width - x * 2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, width, 44)];
    label.text = @"get parametes";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:label];
    
    self.receiveLabel.frame = CGRectMake(x, CGRectGetMaxY(label.frame) + 20, width, 140);
    self.receiveLabel.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:self.receiveLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [button setTitle:@"push" forState:UIControlStateNormal];
    button.frame = CGRectMake((self.view.frame.size.width - 100) * 0.5, CGRectGetMaxY(self.receiveLabel.frame) + 20, 100, 44);
    [button setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
}

- (void)push {

}

- (void)recivedCallBack:(id)callBack {
    
    self.receiveLabel.text = callBack;
}

@end
