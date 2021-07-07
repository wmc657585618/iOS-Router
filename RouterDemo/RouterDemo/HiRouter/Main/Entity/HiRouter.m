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
inline void hi_registFilter(id<HiFilter> filter) {
    if (!_filter)_filter = filter;
}

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
    return [self hi_objectForPath:path withInitParameters:nil];
}

- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters {
    NSObject<HiNetWork> *objc = [NSObject hi_instanceForPath:path withInitParameters:parameters];
    return objc;
}

/// MARK: class
+ (id)hi_objectForClass:(Class<HiInit>)cla withParameters:(id)parameters{
    if ([cla respondsToSelector:@selector(hi_init:)]) return [cla hi_init:parameters];
    return nil;
}

+ (id)hi_instanceForPath:(NSString *)path {
    return [self hi_instanceForPath:path withInitParameters:nil];
}

+ (id)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters{
    HiFilterBody forward = hiFilterMake(path, parameters);
    if ([_filter respondsToSelector:@selector(hiFilterPath:init:)]) {// 有拦截
        forward = [_filter hiFilterPath:path init:parameters];
    }
    
    return [self hi_objectForClass:forward.path.hi_class withParameters:forward.parameters];
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

- (id)hi_pushPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated {
    
    return [self hi_transition:HiRouterTransitionPush
                          path:path
                initParameters:parameters
         modalPresentationStyle:UIModalPresentationFullScreen
                      animated:animated
                    completion:nil];
}

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated completion:(void (^)(void))completion {
    
    return [self hi_transition:HiRouterTransitionPresent
                          path:path
                initParameters:parameters
        modalPresentationStyle:UIModalPresentationFullScreen
                      animated:animated
                    completion:completion];
}

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion {
    
    return [self hi_transition:HiRouterTransitionPresent
                          path:path
                initParameters:parameters
        modalPresentationStyle:modalPresentationStyle
                      animated:animated
                    completion:completion];
}

- (void)viewController:(UIViewController *)viewController pushAnimated:(BOOL)animated{
    if ([self isKindOfClass:UINavigationController.class]) {
        
        UINavigationController *navigationController = (UINavigationController *)self;
        [navigationController pushViewController:viewController animated:animated];

    } else {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (id)hi_transition:(HiRouterTransition)transition path:(NSString *)path initParameters:(id)parameters modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion {
    
    HiFilterBody _body = hiFilterTransitioningMake(path, parameters, transition, modalPresentationStyle);
    if ([_filter respondsToSelector:@selector(hiFilterTransition:path:init:modal:)]) {
        _body = [_filter hiFilterTransition:transition path:path init:parameters modal:modalPresentationStyle];
    }
    
    UIViewController *viewController = [NSObject hi_objectForClass:_body.path.hi_class withParameters:_body.parameters];
    
    if ([viewController isKindOfClass:UIViewController.class]) {
        
        switch (_body.transition) {
                
            case HiRouterTransitionNone:
                break;

            case HiRouterTransitionPush:
            {
                [self viewController:viewController pushAnimated:animated];
            }
                break;
            case HiRouterTransitionPresent:
            {
                viewController.modalPresentationStyle = _body.modal;
                [self presentViewController:viewController animated:animated completion:completion];
            }
                break;
        }
    }
    return viewController;
}

@end
