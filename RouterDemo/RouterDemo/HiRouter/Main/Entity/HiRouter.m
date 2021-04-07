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

- (Class)hi_request:(id)request response:(id(^)(id response))response {
    Class _class = self.hi_class;
    if ([_class respondsToSelector:@selector(hi_request:hi_response:)]) {
        [_class hi_request:request hi_response:response];
    }
    return _class;
}


@end

@interface HiRouterProperty : NSObject

@property (nonatomic, weak) id<HiNetWork> delegate;
@property (nonatomic, copy) id (^block) (id parameters);

@end

@implementation HiRouterProperty

@end

@interface NSObject (_HiRouter)<HiNetWork>

@property (nonatomic, strong, readonly) HiRouterProperty *hi_router_property;

@property (nonatomic, weak) id<HiNetWork> hi_router_delegate;
@property (nonatomic, copy) id (^hi_router_block) (id parameters);

@end

static id<HiFilter> _filter = nil;

@implementation NSObject (HiRouter)

- (HiRouterProperty *)hi_router_property {
    SEL key = @selector(hi_router_delegate);
    HiRouterProperty *_router_property = objc_getAssociatedObject(self, key);
    if (!_router_property) {
        _router_property = [[HiRouterProperty alloc] init];
        objc_setAssociatedObject(self, key, _router_property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _router_property;
}

- (id<HiNetWork>)hi_router_delegate {
    return self.hi_router_property.delegate;
}

- (void)setHi_router_delegate:(id<HiNetWork>)hi_router_delegate {
    self.hi_router_property.delegate = hi_router_delegate;
}

- (id (^)(id))hi_router_block {
    return self.hi_router_property.block;
}

- (void)setHi_router_block:(id (^)(id))hi_router_block {
    self.hi_router_property.block = hi_router_block;
}

/// MARK:- init
/// MARK: instance
- (id)hi_objectForPath:(NSString *)path {
    return [self hi_objectForPath:path withInitParameters:nil request:nil];
}

- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters {
    return [self hi_objectForPath:path withInitParameters:parameters request:nil];
}

- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request {
    NSObject<HiNetWork> *objc =  [NSObject hi_instanceForPath:path withInitParameters:parameters request:request];
    objc.hi_router_delegate = self;
    return objc;
}

/// MARK: class
+ (id)hi_forwardWithPath:(NSString *)path withInitParameters:(id)parameters request:(id)request {
    id<HiNetWork> objc = [self hi_objectForClass:path.hi_class withParameters:parameters];
    if (request && [objc respondsToSelector:@selector(hi_request:)]) [objc hi_request:request];
    return objc;
}

+ (id)hi_objectForClass:(Class<HiNetWork>)cla withParameters:(id)parameters{
    if ([cla respondsToSelector:@selector(hi_init:)]) return [cla hi_init:parameters];
    return nil;
}

+ (id)hi_instanceForPath:(NSString *)path {
    return [self hi_instanceForPath:path withInitParameters:nil request:nil];
}

+ (id)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters{
    return [self hi_instanceForPath:path withInitParameters:parameters request:nil];
}

+ (id)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request {
    HiFilterBody forward = hiFilterMake(path, parameters, request);
    if ([_filter respondsToSelector:@selector(hiFilterPath:init:request:)]) {// 有拦截
        forward = [_filter hiFilterPath:path init:parameters request:request];
    }
    
    return [self hi_forwardWithPath:forward.path withInitParameters:forward.parameters request:forward.request];
}

/// MARK:- filter
+ (void)hi_registFilter:(id<HiFilter>)filter {
    _filter = filter;
}

/// MARK:- other
- (void)hi_makeResponse:(id)response {
    
    if (self.hi_router_block) {
        self.hi_router_block(response);
        return;
    }
    
    if ([self.hi_router_delegate respondsToSelector:@selector(hi_response:)]) {
        [self.hi_router_delegate hi_response:response];
    }
}

@end


@implementation UIViewController (HiRouter)

- (id)hi_pushPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated {
    
    return [self hi_transition:HiRouterTransitionPush
                          path:path
                initParameters:parameters
                       request:request
         modalPresentationStyle:UIModalPresentationNone
                      animated:animated
                    completion:nil];
}

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated completion:(void (^)(void))completion {
    
    return [self hi_transition:HiRouterTransitionPresent
                          path:path
                initParameters:parameters
                       request:request
            modalPresentationStyle:UIModalPresentationFullScreen
                      animated:animated
                    completion:completion];
}

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters request:(id)request modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion {
    
    return [self hi_transition:HiRouterTransitionPresent
                          path:path
                initParameters:parameters
                       request:request
            modalPresentationStyle:modalPresentationStyle
                      animated:animated
                    completion:completion];
}

- (id)hi_transition:(HiRouterTransition)transition path:(NSString *)path initParameters:(id)parameters request:(id)request modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion {
    UIViewController *viewController = nil;
    HiRouterTransition _transition = transition;
    if ([_filter respondsToSelector:@selector(hiFilterTransition:path:init:request:)]) {
        
        HiFilterBody body = [_filter hiFilterTransition:transition path:path init:parameters request:request];
        viewController = [self hi_objectForPath:body.path withInitParameters:body.parameters request:body.request];
        _transition = body.transition;
        
    } else {
        viewController = [self hi_objectForPath:path withInitParameters:parameters request:request];
    }
    
    if ([viewController isKindOfClass:UIViewController.class]) {
        
        switch (_transition) {
                
            case HiRouterTransitionNone:
                break;

            case HiRouterTransitionPush:
            {
                viewController.modalPresentationStyle = modalPresentationStyle;
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
