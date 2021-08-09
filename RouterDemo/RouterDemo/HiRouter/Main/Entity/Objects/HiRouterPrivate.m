//
//  HiRouterPrivate.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiRouterPrivate.h"
#import <objc/runtime.h>


@implementation HiRouterProperty

@end

static id _filter = nil;

@implementation NSObject (HiRouterPrivate)

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

- (id (^)(id))hi_router_block {
    return self.hi_router_property.block;
}

- (void)setHi_filter:(id)hi_filter {
    _filter = hi_filter;
}

- (id)hi_filter {
    return _filter;
}

+ (void)setHi_filter:(id)hi_filter {
    _filter = hi_filter;
}

+ (id)hi_filter {
    return _filter;
}

/// MARK: class
+ (id)hi_objectForClass:(Class<HiInit>)cla withParameters:(id)parameters{
    if ([cla respondsToSelector:@selector(hi_init:)]) return [cla hi_init:parameters];
    return nil;
}
@end
