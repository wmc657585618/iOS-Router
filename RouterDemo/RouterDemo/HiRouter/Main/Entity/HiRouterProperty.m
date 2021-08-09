//
//  HiRouterProperty.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiRouterProperty.h"
#import "HiRouterPrivate.h"


@implementation NSObject (HiRouterProperty)

- (void)setHi_router_delegate:(id<HiNetWork>)hi_router_delegate {
    self.hi_router_property.delegate = hi_router_delegate;
}

- (void)setHi_router_block:(id (^)(id response))hi_router_block {
    self.hi_router_property.block = hi_router_block;
}


@end
