//
//  HiRouterPageReleasObsever.m
//  RouterDemo
//
//  Created by four on 2018/12/19.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterPageReleasObserver.h"
#import "UIViewController+HiRouter_page_delegate.h"

@interface HiRouterPageReleasObserver ()
@property (nonatomic,weak) UIViewController *observer;

@end

@implementation HiRouterPageReleasObserver

- (instancetype)initWithObserver:(UIViewController *)observer
{
    self = [super init];
    if (self) {
        _observer = observer;
    }
    return self;
}

- (void)dealloc {
    
    self.observer.hi_private_page_delegate = nil;
}

@end
