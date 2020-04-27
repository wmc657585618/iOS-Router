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

@interface HiRouterAction ()

@property (nonatomic,assign) UIModalPresentationStyle pModalPresentationStyle;
@property (nonatomic,assign) HiRouterTransitioningAction pAction;

@end

@implementation HiRouterAction

+ (HiRouterAction *)push {
    HiRouterAction *actionModel = [[HiRouterAction alloc] init];
    actionModel.pModalPresentationStyle = UIModalPresentationNone;
    actionModel.pAction = HiRouterTransitioningActionPush;
    return actionModel;
}

+ (HiRouterActionProperty )present {
    return ^(UIModalPresentationStyle moda){
        HiRouterAction *actionModel = [[HiRouterAction alloc] init];
        actionModel.pModalPresentationStyle = moda;
        actionModel.pAction = HiRouterTransitioningActionPresent;
        return actionModel;
    };
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return self.pModalPresentationStyle;
}

- (HiRouterTransitioningAction)action {
    return self.pAction;
}

- (void)dealloc {
    NSLog(@"dealloc");
}
@end
