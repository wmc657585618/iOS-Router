//
//  HiFrameOptionManager.h
//  RouterDemo
//
//  Created by four on 2020/5/21.
//  Copyright © 2020 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    CGRect frame;
    BOOL available; // 是否是 合格
} HiFrameStruct;

@interface HiFrameOptionManager : NSObject

/** 添加 options */
- (void)optionWithAttribute:(NSLayoutAttribute)attribute;

/** 更新 frame 的值 */
- (void)updateFrameValue:(CGFloat)value forAttribute:(NSLayoutAttribute)attribute;

- (CGFloat)frameValueForAttribute:(NSLayoutAttribute)attribute;

- (instancetype)initWitView:(UIView *)view;

@property (nonatomic,assign,readonly) HiFrameStruct frameStruct;

@property (nonatomic,readonly) UIView *_Nullable view;

@end

NS_ASSUME_NONNULL_END
