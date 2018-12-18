//
//  HiRouter+Page.h
//  RouterDemo
//
//  Created by four on 2018/11/12.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouter.h"
#import "HiRouterPageProtocol.h"

@interface HiRouter (Page)

- (HiRouterBuilder *) build:(NSString *)path;

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterNavigationAction)action;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterNavigationAction)action;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterNavigationAction)action;

- (BOOL) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters;

@end



