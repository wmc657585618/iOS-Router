//
//  UIViewController+HiRouterNavigationAction.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "UIViewController+HiRouterNavigationAction.h"

@implementation UIViewController (HiRouterNavigationAction)

- (void)hi_pushPath:(NSString *)path animated:(BOOL)animated {

    [[HiRouter.instance build:path fromViewController:self action:HiRouterNavigationActionPush] buildAnimated:animated completion:nil];
}

- (void)hi_pushPath:(NSString *)path withParameters:(id)parameters animated:(BOOL)animated {

    [[HiRouter.instance build:path fromViewController:self withParameters:parameters action:HiRouterNavigationActionPush] buildAnimated:animated completion:nil];
}

- (void)hi_presentPath:(NSString *)path withParameters:(id)parametes animated:(BOOL)animated completion:(void(^)(void))completion{

    [[HiRouter.instance build:path fromViewController:self withParameters:parametes action:HiRouterNavigationActionPresent] buildAnimated:animated completion:completion];
}

- (void)hi_presentPath:(NSString *)path animated:(BOOL)animated completion:(void(^)(void))completion{

    [[HiRouter.instance build:path fromViewController:self action:HiRouterNavigationActionPresent] buildAnimated:animated completion:completion];
}

- (void)hi_callBackParameters:(id)callBackParameters {

    [HiRouter.instance routerCallBackFromViewController:self callBackParameters:callBackParameters];
}

@end
