//
//  UIViewHiFrameExtension.h
//  RouterDemo
//
//  Created by four on 2020/5/18.
//  Copyright © 2020 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiFrameBuilder.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^HiLayoutFrameBlock)(HiFrameBuilder *builder);

@interface UIView (HiFrame)

- (void)hi_addFrameConstraints:(HiLayoutFrameBlock)block;

@end

NS_ASSUME_NONNULL_END
