//
//  RouterBuilder.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterBuilder.h"

@implementation HiRouterBuilder

- (void)buildAnimated:(BOOL)animated completion:(void(^)(void))completion {
    
    switch (self.navigationAction) {
        case HiRouterTransitioningActionPush:
            [self.fromViewController.navigationController pushViewController:self.toViewController animated:animated];
            break;
        case HiRouterTransitioningActionPresent:
            [self.fromViewController presentViewController:self.toViewController animated:animated completion:completion];
            break;
        case HiRouterTransitioningActionNone:
            
            break;
    }
}
@end
