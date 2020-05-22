//
//  UIButtonHiExtension.m
//  RouterDemo
//
//  Created by four on 2020/5/19.
//  Copyright © 2020 Four. All rights reserved.
//

#import "UIButtonHiExtension.h"

@implementation UIButton (HiExtension)

#pragma mark - ************* image *************
- (void)hi_setNormalImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

- (void)hi_setHighlightedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateHighlighted];
}

- (void)hi_setDisabledImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateDisabled];
}

- (void)hi_setSelectedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateSelected];
}

- (void)hi_setFocusedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateFocused];
}

- (void)hi_setApplicationImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateApplication];
}

- (void)hi_setReservedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateReserved];
}


#pragma mark - ************* background *************

- (void)hi_setNormalBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)hi_setHighlightedBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (void)hi_setDisabledBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateDisabled];
}

- (void)hi_setSelectedBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateSelected];
}

- (void)hi_setFocusedBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateFocused];
}

- (void)hi_setApplicationBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateApplication];
}

- (void)hi_setReservedBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateReserved];
}

#pragma mark - ************* title *************
- (void)hi_setNormalTitle:(NSString *)string {
    [self setTitle:string forState:UIControlStateNormal];
}

- (void)hi_setSelectedTitle:(NSString *)string {
    [self setTitle:string forState:UIControlStateSelected];
}

- (void)hi_setDisabledTitle:(NSString *)string {
    [self setTitle:string forState:UIControlStateDisabled];
}

- (void)hi_setHighlightedTitle:(NSString *)string {
    [self setTitle:string forState:UIControlStateHighlighted];
}

- (void)hi_setFocusedTitle:(NSString *)string {
    [self setTitle:string forState:UIControlStateFocused];
}

- (void)hi_setApplicationTitle:(NSString *)string {
    [self setTitle:string forState:UIControlStateApplication];
}

- (void)hi_setReservedTitle:(NSString *)string {
    [self setTitle:string forState:UIControlStateReserved];
}

#pragma mark - ************* attribute title *************
- (void)hi_setNormalAttributedTitle:(NSAttributedString *)string {
    [self setAttributedTitle:string forState:UIControlStateNormal];
}

- (void)hi_setSelectedAttributedTitle:(NSAttributedString *)string {
    [self setAttributedTitle:string forState:UIControlStateSelected];
}

- (void)hi_setDisabledAttributedTitle:(NSAttributedString *)string {
    [self setAttributedTitle:string forState:UIControlStateDisabled];
}

- (void)hi_setHighlightedAttributedTitle:(NSAttributedString *)string {
    [self setAttributedTitle:string forState:UIControlStateHighlighted];
}

- (void)hi_setFocusedAttributedTitle:(NSAttributedString *)string {
    [self setAttributedTitle:string forState:UIControlStateFocused];
}

- (void)hi_setApplicationAttributedTitle:(NSAttributedString *)string {
    [self setAttributedTitle:string forState:UIControlStateApplication];
}

- (void)hi_setReservedAttributedTitle:(NSAttributedString *)string {
    [self setAttributedTitle:string forState:UIControlStateReserved];
}

#pragma mark - ************* title color *************
- (void)hi_setNormalTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)hi_setSelectedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void)hi_setDisabledTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateDisabled];
}

- (void)hi_setHighlightedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

- (void)hi_setFocusedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateFocused];
}

- (void)hi_setApplicationTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateApplication];
}

- (void)hi_setReservedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateReserved];
}

#pragma mark - ************* title shadow color *************
- (void)hi_setNormalTitleShadowColor:(UIColor *)color {
    [self setTitleShadowColor:color forState:UIControlStateNormal];
}

- (void)hi_setSelectedTitleShadowColor:(UIColor *)color {
    [self setTitleShadowColor:color forState:UIControlStateSelected];
}

- (void)hi_setDisabledTitleShadowColor:(UIColor *)color {
    [self setTitleShadowColor:color forState:UIControlStateDisabled];
}

- (void)hi_setHighlightedTitleShadowColor:(UIColor *)color {
    [self setTitleShadowColor:color forState:UIControlStateHighlighted];
}

- (void)hi_setFocusedTitleShadowColor:(UIColor *)color {
    [self setTitleShadowColor:color forState:UIControlStateFocused];
}

- (void)hi_setApplicationTitleShadowColor:(UIColor *)color {
    [self setTitleShadowColor:color forState:UIControlStateApplication];
}

- (void)hi_setReservedTitleShadowColor:(UIColor *)color {
    [self setTitleShadowColor:color forState:UIControlStateReserved];
}

@end
