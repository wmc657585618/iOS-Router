//
//  HiRouterCategory.h
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouter.h"
#import "HiRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiRouter (Page)

- (HiRouterBuilder *) build:(NSString *)path;

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterNavigationAction)action;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterNavigationAction)action;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterNavigationAction)action;

- (BOOL) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters;

@end

@interface HiRouter (VM)

/******************** view model ********************/

/**
 build view and model in dynamic
 */
- (void) buildViewModelInDynamic:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB;

- (void) invork:(id<HiRouterViewModel>)invork postData:(id)data;

/******************** view model ********************/

@end

@interface HiRouter (Filter)

- (NSObject<HiPageFilterProtocol> *)pageFilterWithPath:(NSString *)path;

- (NSObject<HiNetworkFilterProtocol> *)nwtworkFilterWithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
