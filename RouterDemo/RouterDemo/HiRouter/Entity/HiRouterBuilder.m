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
            [self presetnViewControllerWithAnimated:animated completion:completion];
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

@implementation HiRouterAction

+ (HiRouterActionProperty)install {
    
    return ^(UIModalPresentationStyle moda, HiRouterTransitioningAction action) {
        HiRouterAction *actionModel = [[HiRouterAction alloc] init];
        actionModel.modalPresentationStyle = moda;
        actionModel.action = action;
        return actionModel;
    };
}

- (void)dealloc {
    NSLog(@"dealloc");
}
@end
