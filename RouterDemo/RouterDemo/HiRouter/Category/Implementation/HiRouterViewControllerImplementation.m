//
//  HiRouterViewControllerImplementation.m
//  RouterDemo
//
//  Created by four on 2019/03/19.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"

@implementation HiRouter (ViewController)

- (void)popToPath:(NSString *)path parameters:(id)parameters animated:(BOOL)animated {
    
    UIViewController<HiRouterPageProtocol> *viewController = [self.viewControllers objectForKey:path];
    
    if ([viewController respondsToSelector:@selector(recivedParameters:)]) {
        [viewController recivedParameters:parameters];
    }
    
    [viewController.navigationController popToViewController:viewController animated:animated];
}

- (UIViewController<HiRouterPageProtocol> *)topViewControllerForPath:(NSString *)path {
    return [self.viewControllers objectForKey:path];
}

@end
