//
//  HiBaseViewController.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiBaseViewController.h"

@implementation HiBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

+ (instancetype)hi_init:(id)parameters {
    return [[self alloc] init];
}

@end
