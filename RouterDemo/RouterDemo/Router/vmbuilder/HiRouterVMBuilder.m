//
//  RouterVMBuilder.m
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterVMBuilder.h"
#import <objc/runtime.h>

// release obsever
@interface NSObjectReleaseObsever : NSObject

@property (nonatomic,weak) NSObject *obsever;
- (instancetype)initWithObsever:(NSObject *)obsever;

@end

@interface NSObject (hi_delegate)<HiRouterViewModel>

@property (nonatomic,weak) id<HiRouterViewModel> hi_private_delegate;
@property (nonatomic,strong) NSObjectReleaseObsever *releaseObsever;

@end

@implementation NSObject (hi_delegate)

- (void)setReleaseObsever:(NSObjectReleaseObsever *)releaseObsever {
    objc_setAssociatedObject(self, @selector(releaseObsever), releaseObsever, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSObjectReleaseObsever *)releaseObsever {
    return objc_getAssociatedObject(self, @selector(releaseObsever));
}

- (void)setHi_private_delegate:(NSObject<HiRouterViewModel> *)hi_private_delegate {
    
    if (hi_private_delegate) {
        hi_private_delegate.releaseObsever = [[NSObjectReleaseObsever alloc] initWithObsever:self];
    }
    
    objc_setAssociatedObject(self, @selector(hi_private_delegate), hi_private_delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (NSObject<HiRouterViewModel> *)hi_private_delegate {
    return objc_getAssociatedObject(self, @selector(hi_private_delegate));
}

@end


@implementation NSObjectReleaseObsever

- (instancetype)initWithObsever:(NSObject *)obsever
{
    self = [super init];
    if (self) {
        _obsever = obsever;
    }
    return self;
}

- (void)dealloc {
    self.obsever.hi_private_delegate = nil;
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

