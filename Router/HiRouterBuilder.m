//
//  RouterBuilder.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterBuilder.h"

@implementation HiRouterBuilder

- (void) pushWithContext:(UIViewController *)contextViewController animated:(BOOL)animated {
    
    if (self.viewController) {
        
        [contextViewController.navigationController pushViewController:self.viewController animated:animated];
    }
}

- (void) presentWithContext:(UIViewController *)contextViewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    
    if (self.viewController) {

        [contextViewController presentViewController:self.viewController animated:animated completion:completion];
    }
}

@end
