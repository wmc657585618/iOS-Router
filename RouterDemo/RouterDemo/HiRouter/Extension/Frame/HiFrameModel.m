//
//  HiFrameModel.m
//  ZYBScanSearch
//
//  Created by four on 2020/5/20.
//  Copyright © 2020 zuoyebang. All rights reserved.
//

#import "HiFrameModel.h"
#import "UIViewHiCommon.h"

@interface HiLayoutFrameModel ()

@property (nonatomic,strong) HiFrameOptionManager *option;
@property (nonatomic,weak) UIView *itemValue1;
@property (nonatomic,weak) UIView *itemValue2;
@property (nonatomic,assign) NSLayoutAttribute attributeValue1; // of self
@property (nonatomic,assign) NSLayoutAttribute attributeValue2; // of itemValue2
@property (nonatomic,assign) CGFloat multiplierValue;

@end

@implementation HiLayoutFrameModel
- (instancetype)initWithOption:(HiFrameOptionManager *)option attribute:(NSLayoutAttribute)attribute
{
    self = [super init];
    if (self) {
        _option = option;
        _attributeValue1 = attribute;
        _multiplierValue = 1.0;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _multiplierValue = 1.0;
    }
    return self;
}

- (CGFloat)valueForConstant:(CGFloat)constant {
    UIView *superView = self.option.view.superview;
    
    CGFloat value2 = 0; // x y w h bottom ...
    if (!self.itemValue2) { // 相对 super view
        
        // 不需要相对 super
        BOOL notCheck = NSLayoutAttributeWidth == self.attributeValue1 || NSLayoutAttributeHeight == self.attributeValue1;
        
        if (!notCheck)value2 = [superView boundsValueForAtrribute:self.attributeValue1];
        
    } else if ([self.option.view isEqual:self.itemValue2]) { // 相对 自己
        value2 = [self.option frameValueForAttribute:self.attributeValue2];
        
    } else {
        value2 = [self.itemValue2 valueChangedInView:superView forAttribute:self.attributeValue2];
    }
    
    CGFloat value =  value2 * self.multiplierValue + constant;
    // 将结果 传给 option
    [self.option updateFrameValue:value forAttribute:self.attributeValue1];
    return value;
}

- (void)updatePropertyForModel:(HiLayoutFrameModel *)model{
    model.option = self.option;
    model.attributeValue1 = self.attributeValue1;
    model.itemValue2 = self.itemValue2;
    model.attributeValue2 = self.attributeValue2;
    model.multiplierValue = self.multiplierValue;
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
        [strong updatePropertyForModel:model];
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
    [self updatePropertyForModel:model];
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
        [strong updatePropertyForModel:model];
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

- (instancetype)initWithOption:(HiFrameOptionManager *)option attribute:(NSLayoutAttribute)attribute
{
    self = [super initWithOption:option attribute:attribute];
    if (self) {
    }
    return self;
}

@end
