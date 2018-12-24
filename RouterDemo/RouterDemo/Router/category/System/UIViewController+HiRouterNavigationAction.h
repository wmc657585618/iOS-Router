//
//  UIViewController+HiRouterNavigationAction.h
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiRouterCategory.h"
#import "HiRouterPageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HiRouterNavigationAction)<HiRouterPageProtocol>

- (void)hi_pushPath:(NSString *)path animated:(BOOL)animated;
- (void)hi_pushPath:(NSString *)path withParameters:(id)parameters animated:(BOOL)animated;

- (void)hi_presentPath:(NSString *)path animated:(BOOL)animated completion:(void(^)(void))completion;
- (void)hi_presentPath:(NSString *)path withParameters:(id)parametes animated:(BOOL)animated completion:(void(^)(void))completion;

- (void)hi_callBackParameters:(id)callBackParameters;
@end

NS_ASSUME_NONNULL_END
