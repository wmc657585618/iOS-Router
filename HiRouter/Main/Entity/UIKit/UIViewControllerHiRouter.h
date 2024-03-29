//
//  UIViewControllerHiRouter.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "NSObjectHiRouter.h"

@interface UIViewController (HiRouter)

/// self 是 UINavigationController 或者 UIViewController
/// UINavigationController 直接 push
/// UIViewController 调用 self.navigationController push
- (id)hi_pushPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated;


/// present full screen viewController. 无回调
- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated;

/// present full screen viewController.
- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated completion:(void (^)(void))completion;

/// present viewController.
- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion;

@end

