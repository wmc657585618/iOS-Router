//
//  HiNavigationFourthViewControoler.m
//  RouterDemo
//
//  Created by four on 2019/3/19.
//  Copyright © 2019 Four. All rights reserved.
//

#import "HiNavigationFourthViewControoler.h"

@interface HiNavigationFourthViewControoler ()

@end

@implementation HiNavigationFourthViewControoler

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"nav 4";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 44, 44);
    button.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked {
    
    [self hi_popToPath:NAV_SECONDE animated:true];
}

@end
