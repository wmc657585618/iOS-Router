//
//  UIViewController+HiRouter_page_delegate.h
//  RouterDemo
//
//  Created by four on 2018/12/19.
//  Copyright © 2018 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiRouterPageProtocol.h"

#import "HiRouterPageReleasObserver.h" // for set hi_private_page_delegate = nil;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HiRouter_page_delegate)<HiRouterPageProtocol>

@property (nonatomic,weak) UIViewController<HiRouterPageProtocol> *hi_private_page_delegate;
@property (nonatomic,strong) HiRouterPageReleasObserver *releaseObserver;

@end

NS_ASSUME_NONNULL_END
