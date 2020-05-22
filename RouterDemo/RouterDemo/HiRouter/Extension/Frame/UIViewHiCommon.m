//
//  UIViewHiCommon.m
//  RouterDemo
//
//  Created by four on 2020/5/18.
//  Copyright © 2020 Four. All rights reserved.
//

#import "UIViewHiCommon.h"
#import "NSObjectHiExtension.h"

@interface UIView ()

@property (nonatomic,strong,readonly) NSMapTable *map;
@property (nonatomic,strong,readonly) NSMapTable *frameInViewMap; // 在 view 中的 frame

@end

@implementation UIView (HiCommonSuper)

- (NSMapTable *)map {
    NSMapTable *map = [self hi_getValueForKey:@selector(map)];
    if (!map) {
        map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory];
        [self hi_addRetainNonatomicPropertyForKey:@selector(map) value:map];
    }
    return map;
}

- (NSMapTable *)frameInViewMap {
    NSMapTable *map = [self hi_getValueForKey:@selector(frameInViewMap)];
    if (!map) {
        map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory];
        [self hi_addRetainNonatomicPropertyForKey:@selector(frameInViewMap) value:map];
    }
    return map;
}

// 获取所有父类
- (NSArray *)superViews {
    UIView *view = self.superview;
    
    if (!view) return @[];
    
    NSMutableArray *result = [NSMutableArray array];
    while (view) {
        [result addObject:view];
        view = view.superview;
    }
    return result;
}

- (UIView *)commonSuperViewWithView:(UIView *)view {
    
    if (!view) return nil;
    UIView *superView = [self.map objectForKey:view];
    if (superView) return superView;
    
    NSArray *arr1 = [self superViews];
    NSArray *arr2 = [view superViews];
    NSSet *set = [NSSet setWithArray:arr2];
    for (NSUInteger i = 0; i < arr1.count; ++i) {
        UIView *targetView = arr1[i];
        if ([set containsObject:targetView]) {
            [self.map setObject:targetView forKey:view];
            return targetView;
        }
    }
    
    return nil;
}

- (CGRect)frameConvertToView:(UIView *)view {
    CGRect frame = self.frame;

    if (!view) return frame;
    NSValue *value = [self.frameInViewMap objectForKey:view];
    if (value) return value.CGRectValue;
    frame = [self.superview convertRect:frame toView:view];
    return frame;
}

- (void)updateFrame:(CGRect)frame inView:(UIView *)view {
    if (view) {
        NSValue *value = [NSValue valueWithCGRect:frame];
        [self.frameInViewMap setObject:value forKey:view];
    }
}

@end

#pragma mark - ************* view property *************

@implementation UIView (HiFrameProperty)

/** 在天朝 NSLayoutAttributeLeft 和 NSLayoutAttributeLeading 是一个效果的，布局习惯从左到右 */
- (CGFloat)frame:(CGRect)frame forAttribute:(NSLayoutAttribute)attribute{
    
    switch (attribute) {
        case NSLayoutAttributeLeft:
        case NSLayoutAttributeLeading:
            return CGRectGetMinX(frame);
            
        case NSLayoutAttributeRight:
        case NSLayoutAttributeTrailing:
            return CGRectGetMaxX(frame);
            
        case NSLayoutAttributeTop:
            return CGRectGetMinY(frame);
            
        case NSLayoutAttributeBottom:
            return CGRectGetMaxY(frame);
            
        case NSLayoutAttributeWidth:
            return CGRectGetWidth(frame);
            
        case NSLayoutAttributeHeight:
            return CGRectGetHeight(frame);
            
        case NSLayoutAttributeCenterX:
            return frame.origin.x + frame.size.width * 0.5;
            
        case NSLayoutAttributeCenterY:
            return frame.origin.y + frame.size.height * 0.5;

        default:
            return 0;
    }
}

- (CGFloat)frameValueForAtrribute:(NSLayoutAttribute)attribute {
    return [self frame:self.frame forAttribute:attribute];
}

- (CGFloat)boundsValueForAtrribute:(NSLayoutAttribute)attribute {
    return [self frame:self.bounds forAttribute:attribute];
}

- (CGFloat)valueChangedInView:(UIView *)view forAttribute:(NSLayoutAttribute)attribute {
    
    if ([self.superview isEqual:view]) { // 返回 self
        return [self frameValueForAtrribute:attribute];
    }
    
    if ([self isEqual:view]) {
        return [self boundsValueForAtrribute:attribute];
    }
    
    CGRect frame = [self frameConvertToView:view];
    return [self frame:frame forAttribute:attribute];
}

@end
