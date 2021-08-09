//
//  HiParametersViewController.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiParametersViewController.h"

@interface HiParametersViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation HiParametersViewController

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(0, 100, self.view.frame.size.width, 44.0);
}

+ (instancetype)hi_init:(NSString *)parameters {
    HiParametersViewController *vc = [super hi_init:parameters];
    vc.label.text = [[NSString alloc] initWithFormat:@"收到的参数是: %@",parameters];
    return vc;
}

@end
