//
//  HiRouter+Page.m
//  RouterDemo
//
//  Created by four on 2018/11/12.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouter+Page.h"
#import <objc/runtime.h>
#import "UIViewController+HiRouter_page_delegate.h"

@interface UIViewController (Hi_delegate)<HiRouterPageProtocol>

@property (nonatomic,weak) id<HiRouterPageProtocol> hi_private_page_delegate;

@end

@implementation UIViewController (delegate)

- (void)setHi_private_page_delegate:(id<HiRouterPageProtocol>)hi_private_page_delegate {
    objc_setAssociatedObject(self, @selector(hi_private_page_delegate), hi_private_page_delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<HiRouterPageProtocol>)hi_private_page_delegate {
    return objc_getAssociatedObject(self, @selector(hi_private_page_delegate));
}

@end

@implementation HiRouter (Page)

- (NSString *) keyWithObject:(UIViewController *)object {
    
    return NSStringFromClass(object.class);
}

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

- (UIViewController<HiRouterPageProtocol> *) viewControllerWithPaht:(NSString *)path parameters:(id)parameters {
    
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
    NSObject<HiFilterProtocol> * objce = [self.filters objectForKey:path];
    NSString *realPath = path;
    id realParameters = parameters;
    HiRouterBuilder *builder = [[HiRouterBuilder alloc] init];

    builder.navigationAction = action;
    if (objce) {
        realPath = objce.forwardPath == nil ? path : objce.forwardPath;
        realParameters = objce.defaultParameters == nil ? parameters : objce.defaultParameters;
        builder.navigationAction = objce.navigationAction;
    }
    
    UIViewController<HiRouterPageProtocol> *pViewController = [self viewControllerWithPaht:realPath parameters:realParameters];
    
    pViewController.hi_private_page_delegate = viewController;
    
    builder.toViewController = pViewController;
    builder.fromViewController = viewController;
    
    return builder;
}

- (BOOL) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters {
   
    if ([viewController.hi_private_page_delegate respondsToSelector:@selector(recivedCallBack:)]) {
        
        [viewController.hi_private_page_delegate recivedCallBack:callBackParameters];
        
        return true;
    }
    
    return false;
}

@end
