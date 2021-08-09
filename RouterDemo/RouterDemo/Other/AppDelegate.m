//
//  AppDelegate.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "AppDelegate.h"
#import "HiRouterPath.h"
#import "HiRouterManager.h"
#import "HiRouterManulRegister.h"

#import "HiRouterFilter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _window.backgroundColor = UIColor.whiteColor;
        _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[UIViewController hi_instanceForPath:root]];
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 手动注册
    [HiRouterManulRegister regist];
    
    // 注册过滤器
    // 类方法
//    [HiRouterFilter becomeFilter];
    
    // 实例方法
    HiRouterFilter *filter = [[HiRouterFilter alloc] init];
    [filter becomeFilter];

    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
