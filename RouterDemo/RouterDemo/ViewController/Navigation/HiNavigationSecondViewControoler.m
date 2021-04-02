//
//  HiNavigationSecondViewControoler.m
//  RouterDemo
//
//  Created by four on 2019/3/19.
//  Copyright © 2019 Four. All rights reserved.
//

#import "HiNavigationSecondViewControoler.h"

@interface HiNavigationSecondViewControoler ()

@end

@implementation_router(nav/seconde,HiNavigationSecondViewControoler)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"nav 2";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 44, 44);
    button.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked {
    
}

@end
