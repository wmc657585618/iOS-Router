//
//  UIViewController+HiRouter_page_delegate.m
//  RouterDemo
//
//  Created by four on 2018/12/19.
//  Copyright © 2018 Four. All rights reserved.
//

#import "UIViewController+HiRouter_page_delegate.h"
#import <objc/runtime.h>

@implementation UIViewController (HiRouter_page_delegate)

-(void)setReleaseObsever:(HiRouterPageReleasObsever *)releaseObsever {
    objc_setAssociatedObject(self, @selector(releaseObsever), releaseObsever, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HiRouterPageReleasObsever *)releaseObsever {
    return objc_getAssociatedObject(self, @selector(releaseObsever));
}

- (void)setHi_private_page_delegate:(UIViewController<HiRouterPageProtocol> *)hi_private_page_delegate {
    
    // if hi_private_page_delegate released, self.hi_private_page_delegate will set nil;
    if (hi_private_page_delegate) {
        hi_private_page_delegate.releaseObsever = [[HiRouterPageReleasObsever alloc] initWithObsever:self];
    }
    objc_setAssociatedObject(self, @selector(hi_private_page_delegate), hi_private_page_delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController<HiRouterPageProtocol> *)hi_private_page_delegate {
    return objc_getAssociatedObject(self, @selector(hi_private_page_delegate));
}

@end
