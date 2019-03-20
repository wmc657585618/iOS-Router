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
    
    if ([viewController isEqual:viewController.navigationController.topViewController]) {
        return;
    }
    
    if ([viewController respondsToSelector:@selector(recivedParameters:)] && parameters) {
        [viewController recivedParameters:parameters];
    }
    
    [viewController.navigationController popToViewController:viewController animated:animated];
}

- (void)removePath:(NSString *)path parameters:(id)parameters {

    UIViewController<HiRouterPageProtocol> *viewController = [self.viewControllers objectForKey:path];
    
    if (viewController) {
        
        UINavigationController *nav = viewController.navigationController;
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:nav.viewControllers];
        
        if ([viewController respondsToSelector:@selector(recivedParameters:)] && parameters) {
            [viewController recivedParameters:parameters];
        }
        
        if (viewControllers.count > 1) {
            
            if ([viewController isEqual:nav.topViewController]) {
                [nav popViewControllerAnimated:false];
            } else {
                
                [viewControllers removeObject:viewController];
                nav.viewControllers = viewControllers;
            }
        }
    }
}

- (UIViewController<HiRouterPageProtocol> *)topViewControllerForPath:(NSString *)path {
    return [self.viewControllers objectForKey:path];
}

@end
