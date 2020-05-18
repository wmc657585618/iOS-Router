//
//  UIViewHiCommon.h
//  RouterDemo
//
//  Created by four on 2020/5/18.
//  Copyright © 2020 Four. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HiCommonSuper)

- (UIView * _Nullable )commonSuperViewWithView:(UIView *)view;

// 记录在 view 中的 frame
- (CGRect)frameConvertToView:(UIView *)view;

// 更新 在 view 中的 frame
- (void)updateFrame:(CGRect)frame inView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
