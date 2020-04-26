//
//  HiRouterPageImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"
#import "HiRouter+Filter.h"
#import "HiDealloc.h"

// private delegate
@interface UIViewController (HiRouter_page_delegate)<HiRouterPageProtocol>

@property (nonatomic,weak) UIViewController<HiRouterPageProtocol> *hi_private_page_delegate;

@end

@implementation UIViewController (HiRouter_page_delegate)

- (void)setHi_private_page_delegate:(UIViewController<HiRouterPageProtocol> *)hi_private_page_delegate {
    [self hi_addAssingPropertyForKey:@selector(hi_private_page_delegate) value:hi_private_page_delegate];
}

- (UIViewController<HiRouterPageProtocol> *)hi_private_page_delegate {
    return [self hi_getValueForKey:@selector(hi_private_page_delegate)];
}

@end


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
    
    if (pViewController && [pViewController respondsToSelector:@selector(recivedParameters:)] && parameters) {
        
        [pViewController recivedParameters:parameters];
    }
    
    return pViewController;
}

#pragma mark - public
- (HiRouterBuilder *) build:(NSString *)path {
    
    return [self build:path action:nil];
}

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterAction *)action {
    
    return [self build:path fromViewController:nil action:action];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterAction *)action {
    
    return [self build:path fromViewController:viewController withParameters:nil action:action];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterAction *)action{
    
    // check filter
    id<HiPageFilterProtocol> pageFilter = [self pageFilterWithPath:path];
    
    NSString *realPath = path;
    id realParameters = parameters;
    
    HiRouterBuilder *builder = [[HiRouterBuilder alloc] init];
    builder.transitioningAction = action.action;
    builder.modalPresentationStyle = action.modalPresentationStyle;
    
    if (pageFilter) {
        realPath = pageFilter.forwardPath ? : path;
        realParameters = pageFilter.parameters ? : parameters;
        builder.transitioningAction = pageFilter.transitioningAction;
    }
    
    UIViewController<HiRouterPageProtocol> *targetViewController = [self viewControllerWithPath:realPath parameters:realParameters];
    
    // set delegate,then can callback
    targetViewController.hi_private_page_delegate = viewController;
    
    builder.targetViewController = targetViewController;
    builder.fromViewController = viewController;
    
    // record
    [self.viewControllers setObject:targetViewController forKey:path];
    
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
