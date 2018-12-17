//
//  RouterVMBuilder.m
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterVMBuilder.h"
#import <objc/runtime.h>

@interface NSObject (hi_delegate)<HiRouterViewModel>

@property (nonatomic,weak) id<HiRouterViewModel> hi_private_delegate;

@end

@implementation NSObject (hi_delegate)

- (void)setHi_private_delegate:(id<HiRouterViewModel>)hi_private_delegate {
    objc_setAssociatedObject(self, @selector(hi_private_delegate), hi_private_delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<HiRouterViewModel>)hi_private_delegate {
    return objc_getAssociatedObject(self, @selector(hi_private_delegate));
}

@end

@implementation HiRouterVMBuilder

+ (void) bind:(NSObject<HiRouterViewModel> *)objcA objcB:(NSObject<HiRouterViewModel> *)objcB {

    objcA.hi_private_delegate = objcB;
    objcB.hi_private_delegate = objcA;
}

+(void)objc:(NSObject<HiRouterViewModel> *)objc postData:(id)data {
    
    if ([objc.hi_private_delegate respondsToSelector:@selector(received:)]) {
        
        [objc.hi_private_delegate received:data];
    }
}

@end

