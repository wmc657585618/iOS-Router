//
//  RouterVMBuilder.m
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterVMBuilder.h"
#import <objc/runtime.h>

// release observer
@interface NSObjectReleaseObserver : NSObject

@property (nonatomic,weak) NSObject *observer;
- (instancetype)initWithObsever:(NSObject *)observer;

@end

@interface NSObject (hi_delegate)<HiRouterViewModel>

@property (nonatomic,weak) NSObject<HiRouterViewModel> * hi_private_delegate;
@property (nonatomic,strong) NSObjectReleaseObserver *releaseObserver;

@end

@implementation NSObject (hi_delegate)

- (void)setReleaseObserver:(NSObjectReleaseObserver *)releaseObserver {
    objc_setAssociatedObject(self, @selector(releaseObserver), releaseObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSObjectReleaseObserver *)releaseObserver {
    return objc_getAssociatedObject(self, @selector(releaseObserver));
}

- (void)setHi_private_delegate:(NSObject<HiRouterViewModel> *)hi_private_delegate {
    
    if (hi_private_delegate) {
        hi_private_delegate.releaseObserver = [[NSObjectReleaseObserver alloc] initWithObsever:self];
    }
    
    objc_setAssociatedObject(self, @selector(hi_private_delegate), hi_private_delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (NSObject<HiRouterViewModel> *)hi_private_delegate {
    return objc_getAssociatedObject(self, @selector(hi_private_delegate));
}

@end


@implementation NSObjectReleaseObserver

- (instancetype)initWithObsever:(NSObject *)observer
{
    self = [super init];
    if (self) {
        _observer = observer;
    }
    return self;
}

- (void)dealloc {
    self.observer.hi_private_delegate = nil;
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

