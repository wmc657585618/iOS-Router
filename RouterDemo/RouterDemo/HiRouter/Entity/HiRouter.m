//
//  Router.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouter.h"
#import <objc/runtime.h>

@implementation NSString (HiPathClass)

- (Class)hi_class {
    SEL key = @selector(hi_class);
    return objc_getAssociatedObject(self, key);;
}

- (void)setHi_class:(Class)hi_class {
    SEL key = @selector(hi_class);
    objc_setAssociatedObject(self, key, hi_class, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface HiRouterDelegate : NSObject

@property (nonatomic, weak) id<HiNetWork> delegate;

@end

@implementation HiRouterDelegate

@end

@interface NSObject (_HiRouter)<HiNetWork>

@property (nonatomic, weak) id<HiNetWork> hi_router_delegate;
@property (nonatomic, strong, readonly) HiRouterDelegate *hi_router_weak;

@end

static id<HiFilter> _filter = nil;

@implementation NSObject (HiRouter)

- (HiRouterDelegate *)hi_router_weak {
    SEL key = @selector(hi_router_delegate);
    HiRouterDelegate *_delegate = objc_getAssociatedObject(self, key);
    if (!_delegate) {
        _delegate = [[HiRouterDelegate alloc] init];
        objc_setAssociatedObject(self, key, _delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _delegate;
}

- (id<HiNetWork>)hi_router_delegate {
    return self.hi_router_weak.delegate;
}

- (void)setHi_router_delegate:(id<HiNetWork>)hi_router_delegate {
    self.hi_router_weak.delegate = hi_router_delegate;
}

/// MARK:- instance
- (id)objectForPath:(NSString *)path {
    return [self objectForPath:path withInitParameters:nil];
}

- (id)objectForPath:(NSString *)path withInitParameters:(id)parameters {
    NSObject<HiNetWork> *objc = [NSObject objectForPath:path withInitParameters:parameters request:nil];
    if ([self respondsToSelector:@selector(hi_response:)]) objc.hi_router_delegate = self; // 实现了+delegate
    return objc;
}

- (id)objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request {
    NSObject<HiNetWork> *objc =  [NSObject objectForPath:path withInitParameters:parameters request:request];
    if ([self respondsToSelector:@selector(hi_response:)]) objc.hi_router_delegate = self;
    return objc;
}

- (void)makeResponse:(id)response {
    if ([self.hi_router_delegate respondsToSelector:@selector(hi_response:)]) {
        [self.hi_router_delegate hi_response:response];
    }
}

/// MARK:- class
+ (id)forwardWithPath:(NSString *)path withInitParameters:(id)parameters request:(id)request {
    id<HiNetWork> objc = [self objectForClass:path.hi_class withParameters:parameters];
    if (request && [objc respondsToSelector:@selector(hi_request:)]) [objc hi_request:request];
    return objc;
}

+ (id)objectForClass:(Class<HiNetWork>)cla withParameters:(id)parameters{
    if ([cla respondsToSelector:@selector(hi_init:)]) return [cla hi_init:parameters];
    return nil;
}


+ (id)objectForPath:(NSString *)path {
    return [self objectForPath:path withInitParameters:nil request:nil];
}

+ (id)objectForPath:(NSString *)path withInitParameters:(id)parameters{
    return [self objectForPath:path withInitParameters:parameters request:nil];
}

+ (id)objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request {
    if ([_filter respondsToSelector:@selector(hiFilterPath:init:request:)]) {// 有拦截
        HiFilterBody forward = [_filter hiFilterPath:path init:parameters request:request];
        return [self forwardWithPath:forward.path withInitParameters:forward.parameters request:forward.request];
    }
    
    return [self forwardWithPath:path withInitParameters:parameters request:request];
}

+ (void)registFilter:(id<HiFilter>)filter {
    _filter = filter;
}

@end


@implementation UIViewController (HiRouter)

- (id)pushPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated {
    
    return [self transitioning:HiRouterTransitionPush
                          path:path
                initParameters:parameters
                       request:request
                      animated:animated
                    completion:nil];
}

- (id)presentPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated completion:(void (^)(void))completion {
    
    return [self transitioning:HiRouterTransitionPresent
                          path:path
                initParameters:parameters
                       request:request
                      animated:animated
                    completion:completion];
}

- (id)transitioning:(HiRouterTransition)transitioning path:(NSString *)path initParameters:(id)parameters request:(id)request animated:(BOOL)animated completion:(void (^)(void))completion {
    
    UIViewController *viewController = nil;
    HiRouterTransition _transitioning = transitioning;
    if ([_filter respondsToSelector:@selector(hiFilterTransitioningPath:init:request:)]) {
        
        HiFilterTransitionBody body = [_filter hiFilterTransitioningPath:path init:parameters request:request];
        viewController = [self objectForPath:body.path withInitParameters:body.parameters request:body.request];
        _transitioning = body.transition;
        
    } else {
        viewController = [self objectForPath:path withInitParameters:parameters request:request];
    }
    
    if ([viewController isKindOfClass:UIViewController.class]) {
        
        switch (_transitioning) {
                
            case HiRouterTransitionNone:
                break;

            case HiRouterTransitionPush:
            {
                [self.navigationController pushViewController:viewController animated:animated];
            }
                break;
            case HiRouterTransitionPresent:
            {
                [self presentViewController:viewController animated:animated completion:completion];
            }
                break;
        }
    }
    return viewController;
}

@end
