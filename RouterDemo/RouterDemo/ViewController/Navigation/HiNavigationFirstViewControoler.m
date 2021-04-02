//
//  HiNavigationFirstViewControoler.m
//  RouterDemo
//
//  Created by four on 2019/3/19.
//  Copyright © 2019 Four. All rights reserved.
//

#import "HiNavigationFirstViewControoler.h"

@interface HiNavigationFirstViewControoler ()

@end

@implementation_router(nav/first,HiNavigationFirstViewControoler)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"nav 1";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 44, 44);
    button.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
