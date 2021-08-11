//
//  HiCallBackViewController.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiCallBackViewController.h"

@interface HiCallBackViewController ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UILabel *label;

@end

@implementation HiCallBackViewController

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"点我发送 hello world" forState:UIControlStateNormal];
        [_button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(40, 100, 200, 20);
    
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(0, 130, self.view.frame.size.width, 44.0);
}

- (void)buttonClicked {
    NSString *res = [self hi_makeResponse:@"hello world"];
    self.label.text = res;
}

@end
