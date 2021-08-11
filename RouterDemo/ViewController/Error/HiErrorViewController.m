//
//  HiErrorViewController.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiErrorViewController.h"

@interface HiErrorViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation HiErrorViewController
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"local error";
    }
    return _label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(0, 100, self.view.frame.size.width, 44.0);
}

@end
