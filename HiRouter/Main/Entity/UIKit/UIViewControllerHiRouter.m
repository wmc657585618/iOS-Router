//
//  UIViewControllerHiRouter.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "UIViewControllerHiRouter.h"
#import "HiRouterPrivate.h"

@implementation UIViewController (HiRouter)

#pragma mark *********** private ***********
- (void)hi_viewController:(UIViewController *)viewController pushAnimated:(BOOL)animated{
    if ([self isKindOfClass:UINavigationController.class]) {
        
        UINavigationController *navigationController = (UINavigationController *)self;
        [navigationController pushViewController:viewController animated:animated];

    } else {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (id)hi_viewControllerWithResopnse:(HiResponse *)response animated:(BOOL)animated completion:(void (^)(void))completion {
    
    UIViewController *viewController = [UIViewController hi_objectForClass:response.path.hi_class withParameters:response.parameters];
    
    if ([viewController isKindOfClass:UIViewController.class]) {
        
        switch (response.transition) {
                
            case HiRouterTransitionNone:
                break;

            case HiRouterTransitionPush:
                [self hi_viewController:viewController pushAnimated:animated];

                break;
            case HiRouterTransitionPresent:
            {
                viewController.modalPresentationStyle = response.modal;
                [self presentViewController:viewController animated:animated completion:completion];
            }
                break;
        }
    }
    return viewController;
}

- (id)hi_transition:(HiRouterTransition)transition path:(NSString *)path initParameters:(id)parameters modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion {

    HiResponse *response = [HiResponse instanceWithPath:path parameters:parameters modal:modalPresentationStyle transition:transition];

    if (self.hi_filterChain.count) {
        HiEnvironment *env = [HiEnvironment instanceWithPath:path parameters:parameters modal:modalPresentationStyle transition:transition];

        for (id<HiFilter> filter in self.hi_filterChain) {
            if (env.isBreak) break;
            if ([filter respondsToSelector:@selector(hiFilterTransition:response:)]) {
                [filter hiFilterTransition:env response:response];
            }
        }
    }
    
    return [self hi_viewControllerWithResopnse:response animated:animated completion:completion];
}

#pragma mark *********** public ***********
- (id)hi_pushPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated {
    
    return [self hi_transition:HiRouterTransitionPush
                          path:path
                initParameters:parameters
         modalPresentationStyle:UIModalPresentationFullScreen
                      animated:animated
                    completion:nil];
}

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated {
    return [self hi_transition:HiRouterTransitionPresent
                          path:path
                initParameters:parameters
        modalPresentationStyle:UIModalPresentationFullScreen
                      animated:animated
                    completion:nil];
}

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated completion:(void (^)(void))completion {
    
    return [self hi_transition:HiRouterTransitionPresent
                          path:path
                initParameters:parameters
        modalPresentationStyle:UIModalPresentationFullScreen
                      animated:animated
                    completion:completion];
}

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion {
    
    return [self hi_transition:HiRouterTransitionPresent
                          path:path
                initParameters:parameters
        modalPresentationStyle:modalPresentationStyle
                      animated:animated
                    completion:completion];
}

@end
