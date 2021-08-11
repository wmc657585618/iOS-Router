//
//  HiFilterViewController.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiFilterViewController.h"

@interface HiFilterViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *button1;

@end

@implementation HiFilterViewController

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"点击跳转正常页面" forState:UIControlStateNormal];
        [_button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"点击跳转过滤页面" forState:UIControlStateNormal];
        [_button1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(buttonClicked1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(40, 100, 200, 20);
    
    [self.view addSubview:self.button1];
    self.button1.frame = CGRectMake(40, 130, 200, 20);
}

- (void)buttonClicked:(UIButton *)button {
    [self hi_pushPath:filter_normal withInitParameters:nil animated:true];
}

- (void)buttonClicked1:(UIButton *)button {
    [self hi_pushPath:filter_normal withInitParameters:@"" animated:true];
}
@end
