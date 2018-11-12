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

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters;

- (BOOL) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters;

@end

@interface UIViewController (Hi_delegate)

@property (nonatomic, weak) id<HiRouterPageProtocol> hi_private_page_delegate;

@end


