//
//  HiBaseViewController.m
//  RouterDemo
//
//  Created by four on 2019/1/3.
//  Copyright © 2019 Four. All rights reserved.
//

#import "HiBaseViewController.h"

@interface HiBaseViewController ()

@end

@implementation HiBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

+ (instancetype)hi_init:(id)parameters {
    return [[self alloc] init];
}

@end
