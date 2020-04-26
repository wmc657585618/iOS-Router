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
    
    switch (self.transitioningAction) {
        case HiRouterTransitioningActionPush:
        {
            if ([self.fromViewController isKindOfClass:UINavigationController.class]) {
                UINavigationController *nav = (UINavigationController *)self.fromViewController;
                [nav pushViewController:self.targetViewController animated:animated];
                
            } else {
                
                [self.fromViewController.navigationController pushViewController:self.targetViewController animated:animated];
            }
        }
            break;
        case HiRouterTransitioningActionPresent:
            break;
        case HiRouterTransitioningActionNone:
            break;
    }
}

- (void)presetnViewControllerWithAnimated:(BOOL)animated completion:(void(^)(void))completion {
    self.targetViewController.modalPresentationStyle = self.modalPresentationStyle;
    [self.fromViewController presentViewController:self.targetViewController animated:animated completion:completion];
}
@end
