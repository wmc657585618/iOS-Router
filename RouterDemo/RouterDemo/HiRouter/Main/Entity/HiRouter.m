//
//  Router.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouter.h"
#import "HiRouterProperty.h"
#import "HiRouterPrivate.h"

static NSMutableDictionary *_dictionary = nil;
@implementation NSString (HiPathClass)

- (Class)hi_class {
    return [_dictionary valueForKey:self];
}

- (void)setHi_class:(Class)hi_class {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dictionary = [NSMutableDictionary dictionary];
    });
    [_dictionary setValue:hi_class forKey:self];
}

- (Class)hi_request:(id)request response:(id(^)(id response))response {
    Class _class = self.hi_class;
    if ([_class respondsToSelector:@selector(hi_request:hi_response:)]) {
        [_class hi_request:request hi_response:response];
    }
    return _class;
}

@end

@implementation NSObject (HiRouter)

- (void)setHi_router_delegate:(id<HiNetWork>)hi_router_delegate {
    self.hi_router_property.delegate = hi_router_delegate;
}

- (void)setHi_router_block:(id (^)(id response))hi_router_block {
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

+ (id)hi_instanceForPath:(NSString *)path {
    return [self hi_instanceForPath:path withInitParameters:nil];
}

+ (id)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters{
    HiFilterBody forward = hiFilterMake(path, parameters);
    if ([self.hi_filter respondsToSelector:@selector(hiFilterPath:)]) {// 有拦截
        HiEnvironment *env = [[HiEnvironment alloc] init];
        env.parameters = parameters;
        env.path = path;
        forward = [self.hi_filter hiFilterPath:env];
    }
    
    return [self hi_objectForClass:forward.path.hi_class withParameters:forward.parameters];
}

/// MARK:- other
- (id)hi_makeResponse:(id)response {
    
    if (self.hi_router_block) {
        return self.hi_router_block(response);
    }
    
    if ([self.hi_router_delegate respondsToSelector:@selector(hi_response:)]) {
        return [self.hi_router_delegate hi_response:response];
    }
    
    return nil;
}

- (void)becomeFilter {
    if ([self conformsToProtocol:@protocol(HiFilter)]) {
        if (!self.hi_filter) self.hi_filter = self;
    }
}

+ (void)becomeFilter {
    if ([self conformsToProtocol:@protocol(HiFilter)]) {
        if (!self.hi_filter) self.hi_filter = self;
    }
}

@end

