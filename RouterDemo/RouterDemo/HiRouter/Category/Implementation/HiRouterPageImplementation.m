//
//  HiRouterPageImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"
#import "HiRouter+Filter.h"
#import "NSObjectHiExtension.h"

typedef void(^HiRouterCallBlock)(id parameters);

// private delegate
@interface UIViewController (HiRouter_page_delegate)<HiRouterPageProtocol>

@property (nonatomic,weak) UIViewController<HiRouterPageProtocol> *hi_private_page_delegate;
@property (nonatomic,copy) HiRouterCallBlock hi_pBlock;

@end

@implementation UIViewController (HiRouter_page_delegate)

- (void)setHi_private_page_delegate:(UIViewController<HiRouterPageProtocol> *)hi_private_page_delegate {
    [self hi_addAssingPropertyForKey:@selector(hi_private_page_delegate) value:hi_private_page_delegate];
}

- (UIViewController<HiRouterPageProtocol> *)hi_private_page_delegate {
    return [self hi_getValueForKey:@selector(hi_private_page_delegate)];
}

- (void)setHi_pBlock:(HiRouterCallBlock)hi_pBlock {
    [self hi_addCopyPropertyForKey:@selector(hi_pBlock) value:hi_pBlock];
}

- (HiRouterCallBlock)hi_pBlock {
    return [self hi_getValueForKey:@selector(hi_pBlock)];
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
    
    return [self build:path action:nil block:nil];
}

- (HiRouterBuilder *) build:(NSString *)path block:(HiRouterCallBlock)block {
    
    return [self build:path action:nil block:block];
}

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterAction *)action {
    
    return [self build:path fromViewController:nil action:action block:nil];
}

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterAction *)action block:(HiRouterCallBlock)block {
    
    return [self build:path fromViewController:nil action:action block:block];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterAction *)action {
    
    return [self build:path fromViewController:viewController withParameters:nil action:action];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterAction *)action block:(HiRouterCallBlock)block {
    
    return [self build:path fromViewController:viewController withParameters:nil action:action];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterAction *)action{
    
    return [self build:path fromViewController:viewController withParameters:parameters action:action block:nil];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterAction *)action block:(HiRouterCallBlock)block {
    
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
       builder.modalPresentationStyle = pageFilter.modalPresentationStyle;
    }

    UIViewController<HiRouterPageProtocol> *targetViewController = [self viewControllerWithPath:realPath parameters:realParameters];

    // set delegate,then can callback
    if(viewController) targetViewController.hi_private_page_delegate = viewController;
    if (block) targetViewController.hi_pBlock = block;

    builder.targetViewController = targetViewController;
    builder.fromViewController = viewController;

    // record
    [self.viewControllers setObject:targetViewController forKey:path];

    return builder;
}

- (HiRouterCallBackType) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters {
    
    if ([viewController.hi_private_page_delegate respondsToSelector:@selector(recivedCallBack:)]) {
        
        // post data to delegate
        [viewController.hi_private_page_delegate recivedCallBack:callBackParameters];
        return HiRouterCallBackTypeDelegate;
    }
    
    if (viewController.hi_pBlock) {
        viewController.hi_pBlock(callBackParameters);
        return HiRouterCallBackTypeBlock;
    }
    
    return HiRouterCallBackTypeNone;
}

@end
