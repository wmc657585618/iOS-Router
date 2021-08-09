//
//  NSObjectHiRouter.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "NSObjectHiRouter.h"
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

- (id)hi_request:(id)request{
    Class _class = self.hi_class;
    if ([_class respondsToSelector:@selector(hi_request:)]) {
        return [_class hi_request:request];
    }
    return nil;
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
    return [NSObject hi_instanceForPath:path withInitParameters:parameters];;
}

+ (id)hi_instanceForPath:(NSString *)path {
    return [self hi_instanceForPath:path withInitParameters:nil];
}

+ (id)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters{
    HiResponse *response = [HiResponse responseWithPath:path parameters:parameters];
    if ([self.hi_filter respondsToSelector:@selector(hiFilterPath:response:)]) {// 有拦截
        HiEnvironment *env = [HiEnvironment environmentWithPath:path parameters:parameters];
        [self.hi_filter hiFilterPath:env response:response];
    }
    
    return [self hi_objectForClass:response.path.hi_class withParameters:response.parameters];
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

@end
