//
//  HiFilterNormalViewController.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiFilterNormalViewController.h"

@interface HiFilterNormalViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation HiFilterNormalViewController

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"正常页面";
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(0, 130, self.view.frame.size.width, 44.0);
}

@end
