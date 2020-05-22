//
//  UIButtonHiExtension.h
//  RouterDemo
//
//  Created by four on 2020/5/19.
//  Copyright © 2020 Four. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HiExtension)

#pragma mark - ************* image *************
- (void)hi_setNormalImage:(UIImage *)image;

- (void)hi_setHighlightedImage:(UIImage *)image;

- (void)hi_setDisabledImage:(UIImage *)image;

- (void)hi_setSelectedImage:(UIImage *)image;

- (void)hi_setFocusedImage:(UIImage *)image;

- (void)hi_setApplicationImage:(UIImage *)image;

- (void)hi_setReservedImage:(UIImage *)image;


#pragma mark - ************* background *************

- (void)hi_setNormalBackgroundImage:(UIImage *)image;

- (void)hi_setHighlightedBackgroundImage:(UIImage *)image;

- (void)hi_setDisabledBackgroundImage:(UIImage *)image;

- (void)hi_setSelectedBackgroundImage:(UIImage *)image;

- (void)hi_setFocusedBackgroundImage:(UIImage *)image;

- (void)hi_setApplicationBackgroundImage:(UIImage *)image;

- (void)hi_setReservedBackgroundImage:(UIImage *)image;

#pragma mark - ************* title *************
- (void)hi_setNormalTitle:(NSString *)string;

- (void)hi_setSelectedTitle:(NSString *)string;

- (void)hi_setDisabledTitle:(NSString *)string;

- (void)hi_setHighlightedTitle:(NSString *)string;

- (void)hi_setFocusedTitle:(NSString *)string;

- (void)hi_setApplicationTitle:(NSString *)string;

- (void)hi_setReservedTitle:(NSString *)string;

#pragma mark - ************* attribute title *************
- (void)hi_setNormalAttributedTitle:(NSAttributedString *)string;

- (void)hi_setSelectedAttributedTitle:(NSAttributedString *)string;

- (void)hi_setDisabledAttributedTitle:(NSAttributedString *)string;

- (void)hi_setHighlightedAttributedTitle:(NSAttributedString *)string;

- (void)hi_setFocusedAttributedTitle:(NSAttributedString *)string;

- (void)hi_setApplicationAttributedTitle:(NSAttributedString *)string;

- (void)hi_setReservedAttributedTitle:(NSAttributedString *)string;

#pragma mark - ************* title color *************
- (void)hi_setNormalTitleColor:(UIColor *)color;

- (void)hi_setSelectedTitleColor:(UIColor *)color;

- (void)hi_setDisabledTitleColor:(UIColor *)color;

- (void)hi_setHighlightedTitleColor:(UIColor *)color;

- (void)hi_setFocusedTitleColor:(UIColor *)color;

- (void)hi_setApplicationTitleColor:(UIColor *)color;

- (void)hi_setReservedTitleColor:(UIColor *)color;

#pragma mark - ************* title shadow color *************
- (void)hi_setNormalTitleShadowColor:(UIColor *)color;

- (void)hi_setSelectedTitleShadowColor:(UIColor *)color;

- (void)hi_setDisabledTitleShadowColor:(UIColor *)color;

- (void)hi_setHighlightedTitleShadowColor:(UIColor *)color;

- (void)hi_setFocusedTitleShadowColor:(UIColor *)color;

- (void)hi_setApplicationTitleShadowColor:(UIColor *)color;

- (void)hi_setReservedTitleShadowColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
