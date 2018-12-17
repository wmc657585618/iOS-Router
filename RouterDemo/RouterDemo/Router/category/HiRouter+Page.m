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
    
    return [self build:path fromViewController:nil];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController{
    
    return [self build:path fromViewController:viewController withParameters:nil];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters {
    
    // check filter
    NSObject<HiFilterProtocol> * objce = [self.filters objectForKey:path];
    NSString *realPath = path;
    id realParameters = parameters;
    
    if (objce) {
        realPath = objce.forwardPath == nil ? path : objce.forwardPath;
        realParameters = objce.defaultParameters == nil ? parameters : objce.defaultParameters;
    }
    
    HiRouterBuilder *builder = [[HiRouterBuilder alloc] init];
    
    UIViewController<HiRouterPageProtocol> *pViewController = [self viewControllerWithPaht:realPath parameters:realParameters];
    
    pViewController.hi_private_page_delegate = viewController;
    
    builder.viewController = pViewController;
    
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

@implementation UIViewController (delegate)

- (void)setHi_private_page_delegate:(id<HiRouterPageProtocol>)hi_private_page_delegate {
    objc_setAssociatedObject(self, @selector(hi_private_page_delegate), hi_private_page_delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<HiRouterPageProtocol>)hi_private_page_delegate {
    return objc_getAssociatedObject(self, @selector(hi_private_page_delegate));
}

@end
