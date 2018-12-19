//
//  HiRouterPageReleasObsever.m
//  RouterDemo
//
//  Created by four on 2018/12/19.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterPageReleasObsever.h"
#import "UIViewController+HiRouter_page_delegate.h"

@interface HiRouterPageReleasObsever ()
@property (nonatomic,weak) UIViewController *obsever;

@end

@implementation HiRouterPageReleasObsever

- (instancetype)initWithObsever:(UIViewController *)obsever
{
    self = [super init];
    if (self) {
        _obsever = obsever;
    }
    return self;
}

- (void)dealloc {
    
    self.obsever.hi_private_page_delegate = nil;
}

@end
