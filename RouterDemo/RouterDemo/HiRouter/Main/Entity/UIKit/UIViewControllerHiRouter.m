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
- (void)viewController:(UIViewController *)viewController pushAnimated:(BOOL)animated{
    if ([self isKindOfClass:UINavigationController.class]) {
        
        UINavigationController *navigationController = (UINavigationController *)self;
        [navigationController pushViewController:viewController animated:animated];

    } else {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (id)hi_transition:(HiRouterTransition)transition path:(NSString *)path initParameters:(id)parameters modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion {

    HiResponse *response = hiFilterTransitioningMake(path, parameters, transition, modalPresentationStyle);
    
    if ([self.hi_filter respondsToSelector:@selector(hiFilterTransition:response:)]) {
        HiEnvironment *env = [[HiEnvironment alloc] init];
        env.path = path;
        env.parameters = parameters;
        env.transition = transition;
        env.modal = modalPresentationStyle;
        
        [self.hi_filter hiFilterTransition:env response:response];
    }
    
    UIViewController *viewController = [UIViewController hi_objectForClass:response.path.hi_class withParameters:response.parameters];
    
    if ([viewController isKindOfClass:UIViewController.class]) {
        
        switch (response.transition) {
                
            case HiRouterTransitionNone:
                break;

            case HiRouterTransitionPush:
            {
                [self viewController:viewController pushAnimated:animated];
            }
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
