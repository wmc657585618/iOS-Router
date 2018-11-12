//
//  TabBarController.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "TabBarController.h"

#import "HiRouter_h.h"

#import "NavigationController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *home = [HiRouter.instance build:@"home"].viewController;
    
    NavigationController *homeNav = [[NavigationController alloc] initWithRootViewController:home];
    
    homeNav.tabBarItem.title = @"home";

    
    UIViewController *me = [HiRouter.instance build:@"me"].viewController;
    
    NavigationController *meNav = [[NavigationController alloc] initWithRootViewController:me];
    
    meNav.tabBarItem.title = @"me";
    
    self.viewControllers  = @[homeNav,meNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
