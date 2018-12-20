//
//  HiRouterPageImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"

@implementation HiRouter (Page)

// get viewcontroller with path
- (UIViewController<HiRouterPageProtocol> *) viewControllerWithPath:(NSString *)path {
    
    NSString *className = [self.routeDictionary objectForKey:path];
    
    NSAssert(className.length > 0, @"⚠️ no path match : %@!",path);
    
    Class class = NSClassFromString(className);
    
    NSAssert(class != nil, @"⚠️ has no class : %@!",className);
    
    id vc = [[class alloc] init];
    
    NSAssert([vc isKindOfClass:UIViewController.class], @"⚠️ class is not UIViewController!");
    
    if ([vc isKindOfClass:UIViewController.class]) {
        return vc;
    }
    
    return nil;
}

// post parameters to viewcontroller
- (UIViewController<HiRouterPageProtocol> *) viewControllerWithPath:(NSString *)path parameters:(id)parameters {
    
    UIViewController<HiRouterPageProtocol> *pViewController = [self viewControllerWithPath:path];
    
    if (pViewController && [pViewController respondsToSelector:@selector(recivedParameters:)]) {
        
        [pViewController recivedParameters:parameters];
    }
    
    return pViewController;
}

/******************** page ********************/
- (HiRouterBuilder *) build:(NSString *)path {
    
    return [self build:path action:HiRouterNavigationActionNone];
}

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterNavigationAction)action {
    
    return [self build:path fromViewController:nil action:action];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterNavigationAction)action {
    
    return [self build:path fromViewController:viewController withParameters:nil action:action];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterNavigationAction)action{
    
    // check filter
    NSObject<HiPageFilterProtocol> * objce = [self pageFilterWithPath:path];
    
    NSString *realPath = path;
    id realParameters = parameters;
    
    HiRouterBuilder *builder = [[HiRouterBuilder alloc] init];
    builder.navigationAction = action;
    
    if (objce) {
        realPath = objce.forwardPath == nil ? path : objce.forwardPath;
        realParameters = objce.defaultParameters == nil ? parameters : objce.defaultParameters;
        builder.navigationAction = objce.navigationAction;
    }
    
    UIViewController<HiRouterPageProtocol> *pViewController = [self viewControllerWithPath:realPath parameters:realParameters];
    
    // set delegate,then can callback
    pViewController.hi_private_page_delegate = viewController;
    
    builder.toViewController = pViewController;
    builder.fromViewController = viewController;
    
    return builder;
}

- (BOOL) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters {
    
    if ([viewController.hi_private_page_delegate respondsToSelector:@selector(recivedCallBack:)]) {
        
        // post data to delegate
        [viewController.hi_private_page_delegate recivedCallBack:callBackParameters];
        
        return true;
    }
    
    return false;
}

@end
