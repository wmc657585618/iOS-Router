//
//  UIViewHiFrameExtension.m
//  RouterDemo
//
//  Created by four on 2020/5/18.
//  Copyright © 2020 Four. All rights reserved.
//

#import "UIViewHiFrameExtension.h"
#import "NSObjectHiExtension.h"
#import "UIViewHiCommon.h"

#pragma mark - ************* view property *************

@interface UIView (HiFrameProperty)

@property (nonatomic,assign) CGFloat hi_x;
@property (nonatomic,assign) CGFloat hi_y;
@property (nonatomic,assign) CGFloat hi_w;
@property (nonatomic,assign) CGFloat hi_h;

@end

@implementation UIView (HiFrameProperty)

#pragma mark - ************* x *************
- (void)setHi_x:(CGFloat)hi_x {
    SEL sel = @selector(hi_x);
    [self hi_addAssingPropertyForKey:sel value:@(hi_x)];
}

- (CGFloat)hi_x {
    SEL sel = @selector(hi_x);

    NSNumber *value = [self hi_getValueForKey:sel];
    if (value) return value.doubleValue;
    return self.frame.origin.x;
}

#pragma mark - ************* y *************
- (void)setHi_y:(CGFloat)hi_y {
    SEL sel = @selector(hi_y);
    [self hi_addAssingPropertyForKey:sel value:@(hi_y)];
}

- (CGFloat)hi_y {
    NSNumber *value = [self hi_getValueForKey:@selector(hi_y)];
    if (value) return value.doubleValue;
    return self.frame.origin.y;
}

#pragma mark - ************* w *************
- (void)setHi_w:(CGFloat)hi_w {
    SEL sel = @selector(hi_w);
    [self hi_addAssingPropertyForKey:sel value:@(hi_w)];
}

- (CGFloat)hi_w {
    NSNumber *value = [self hi_getValueForKey:@selector(hi_w)];
    if (value) return value.doubleValue;
    return self.frame.size.width;
}

#pragma mark - ************* h *************
- (void)setHi_h:(CGFloat)hi_h {
    SEL sel = @selector(hi_h);
    [self hi_addAssingPropertyForKey:sel value:@(hi_h)];
}

- (CGFloat)hi_h {
    NSNumber *value = [self hi_getValueForKey:@selector(hi_h)];
    if (value) return value.doubleValue;
    return self.frame.size.height;
}

@end

typedef struct {
    id objc;
    BOOL result; // 是否是同类型
} HiFrameStruc;
#pragma mark - ************* view property *************

@interface HiLayoutFrameModel ()

@property (nonatomic,weak) UIView *itemValue1;
@property (nonatomic,weak) UIView *itemValue2;
@property (nonatomic,assign) NSLayoutAttribute attributeValue1;
@property (nonatomic,assign) NSLayoutAttribute attributeValue2;
@property (nonatomic,assign) CGFloat multiplierValue;

@end

@implementation HiLayoutFrameModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _multiplierValue = 1.0;
    }
    return self;
}

/** 在天朝 NSLayoutAttributeLeft 和 NSLayoutAttributeLeading 是一个效果的，布局习惯从左到右 */
// 在 superview 中的值
- (CGFloat)valueForView:(UIView *)view inSuperView:(UIView *)superView attribute:(NSLayoutAttribute)attribute{
    
    if (!view) return 0;
    
    CGRect frame = view.frame;
    if (superView) frame = [view frameConvertToView:superView];
    
    return [self frame:frame forAttribute:attribute];
}

- (CGFloat)frame:(CGRect)frame forAttribute:(NSLayoutAttribute)attribute{
    
    switch (attribute) {
        case NSLayoutAttributeLeft:
        case NSLayoutAttributeLeading:
            return CGRectGetMinX(frame);
            
        case NSLayoutAttributeRight:
        case NSLayoutAttributeTrailing:
            return CGRectGetMidX(frame);
            
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
- (CGFloat)valueForConstant:(CGFloat)constant {
    UIView *superView = self.itemValue1.superview;
    
    CGFloat value2 = 0;
    if (!self.itemValue2) { // 相对 super view
        
        // 不需要相对 super
        BOOL notCheck = NSLayoutAttributeWidth == self.attributeValue1 || NSLayoutAttributeHeight == self.attributeValue1;
        
        if (!notCheck){
            value2 = [self frame:superView.frame forAttribute:self.attributeValue1];
        }
        
    } else {
        
        if (self.itemValue2.superview == superView) { // 相同super
            value2 = [self frame:self.itemValue2.frame forAttribute:self.attributeValue2];
        } else {
            
            value2 = [self valueForView:self.itemValue2 inSuperView:superView attribute:self.attributeValue2];
        }
    }
    
    CGFloat value =  value2 * self.multiplierValue + constant;
    [self updateFrameValue:value];
    return value;
}

// 更新 x y w h
- (void)updateFrameValue:(CGFloat)value {
    switch (self.attributeValue1) {
        case NSLayoutAttributeLeft:
        case NSLayoutAttributeLeading:
            self.itemValue1.hi_x = value;
            break;

        case NSLayoutAttributeRight:
        case NSLayoutAttributeTrailing:
            self.itemValue1.hi_x = value - self.itemValue1.hi_w;
            break;
            
        case NSLayoutAttributeTop:
            self.itemValue1.hi_y = value;
            break;

        case NSLayoutAttributeBottom:
            self.itemValue1.hi_y = value - self.itemValue1.hi_h;;
            break;

        case NSLayoutAttributeWidth:
            self.itemValue1.hi_w = value;
            break;

        case NSLayoutAttributeHeight:
            self.itemValue1.hi_h = value;
            break;

        case NSLayoutAttributeCenterX: // centerX =frame.origin.x + frame.size.width * 0.5
            self.itemValue1.hi_x = value - self.itemValue1.hi_w * 0.5;
            break;
            
        case NSLayoutAttributeCenterY: // centerY = frame.origin.y + frame.size.height * 0.5
            self.itemValue1.hi_y = value - self.itemValue1.hi_h * 0.5;;
            break;

        default:
            break;
    }
}

@end


#pragma mark - ************* property *************
@implementation HiFramConstantModel

- (HiFramConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        return [strong valueForConstant:constant];
    };
}

@end

@implementation HiFrameMultiplierModel

- (HiFrameMultiplierBlock)multiplier {
    __weak typeof(self) weak = self;
    return ^(CGFloat multiplier) {
        __strong typeof(weak) strong = weak;
        HiFramConstantModel *model = [[HiFramConstantModel alloc] init];
        model.itemValue1 = strong.itemValue1;
        model.attributeValue1 = strong.attributeValue1;
        model.itemValue2 = strong.itemValue2;
        model.attributeValue2 = strong.attributeValue2;
        model.multiplierValue = multiplier;
        return model;
    };
}

- (HiFramConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        return [strong valueForConstant:constant];
    };
}

@end

@implementation HiFrameItemAttributeModel

- (HiFrameMultiplierModel *)modelForAttribute:(NSLayoutAttribute)attribute {
    HiFrameMultiplierModel *model = [[HiFrameMultiplierModel alloc] init];
    model.itemValue1 = self.itemValue1;
    model.attributeValue1 = self.attributeValue1;
    model.itemValue2 = self.itemValue2;
    model.attributeValue2 = attribute;
    return model;
}

- (HiFrameItemAttributeBlock)attribute {
    __weak typeof(self) weak = self;
    return ^(NSLayoutAttribute attribute) {
        __strong typeof(weak) strong = weak;
        return [strong modelForAttribute:attribute];
    };
}

- (HiFrameMultiplierModel *)left {
    return [self modelForAttribute:NSLayoutAttributeLeft];
}

- (HiFrameMultiplierModel *)right {
    return [self modelForAttribute:NSLayoutAttributeRight];
}

- (HiFrameMultiplierModel *)top {
    return [self modelForAttribute:NSLayoutAttributeTop];
}

- (HiFrameMultiplierModel *)bottom {
    return [self modelForAttribute:NSLayoutAttributeBottom];
}

- (HiFrameMultiplierModel *)leading {
    return [self modelForAttribute:NSLayoutAttributeLeading];
}

- (HiFrameMultiplierModel *)trailing {
    return [self modelForAttribute:NSLayoutAttributeTrailing];
}

- (HiFrameMultiplierModel *)width {
    return [self modelForAttribute:NSLayoutAttributeWidth];
}

- (HiFrameMultiplierModel *)height {
    return [self modelForAttribute:NSLayoutAttributeHeight];
}

- (HiFrameMultiplierModel *)centerX {
    return [self modelForAttribute:NSLayoutAttributeCenterY];
}

- (HiFrameMultiplierModel *)centerY {
    return [self modelForAttribute:NSLayoutAttributeCenterY];
}

- (HiFramConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        strong.attributeValue2 = strong.attributeValue1;
        return [strong valueForConstant:constant];
    };
}

@end

@implementation HiFrameRelatedModel

- (HiFrameRelatedBlock)equal {
    __weak typeof(self) weak = self;
    return  ^(UIView *view) {
        __strong typeof(weak) strong = weak;
        HiFrameItemAttributeModel *model = [[HiFrameItemAttributeModel alloc] init];
        model.itemValue1 = strong.itemValue1;
        model.attributeValue1 = strong.attributeValue1;
        model.itemValue2 = view;
        return model;
    };
}

- (HiFramConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        strong.attributeValue2 = strong.attributeValue1;
        return [strong valueForConstant:constant];
    };
}

@end

#pragma mark - ************* property *************


@implementation UIView (HiFrame)

- (HiFrameRelatedModel *)modelForAttribute:(NSLayoutAttribute)attribute{
    HiFrameRelatedModel *model = [[HiFrameRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = attribute;
    return model;
}

- (HiFrameRelatedModel *)hi_left {
    return [self modelForAttribute:NSLayoutAttributeLeft];
}

- (HiFrameRelatedModel *)hi_right {
    return [self modelForAttribute:NSLayoutAttributeRight];
}

- (HiFrameRelatedModel *)hi_top {
    return [self modelForAttribute:NSLayoutAttributeTop];
}

- (HiFrameRelatedModel *)hi_bottom {
    return [self modelForAttribute:NSLayoutAttributeBottom];
}

- (HiFrameRelatedModel *)hi_leading {
    return [self modelForAttribute:NSLayoutAttributeLeading];
}

- (HiFrameRelatedModel *)hi_trailing {
    return [self modelForAttribute:NSLayoutAttributeTrailing];
}

- (HiFrameRelatedModel *)hi_width {
    return [self modelForAttribute:NSLayoutAttributeWidth];
}

- (HiFrameRelatedModel *)hi_height {
    return [self modelForAttribute:NSLayoutAttributeHeight];
}

- (HiFrameRelatedModel *)hi_centerX {
    return [self modelForAttribute:NSLayoutAttributeCenterX];
}

- (HiFrameRelatedModel *)hi_centerY {
    return [self modelForAttribute:NSLayoutAttributeCenterY];
}

- (void)hi_addFrameConstraints:(HiLayoutFrameBlock)block {
    
    if (block) {
        block(self);
        self.frame = CGRectMake(self.hi_x, self.hi_y, self.hi_w, self.hi_h);
    }
    
    block = nil;
}

@end
