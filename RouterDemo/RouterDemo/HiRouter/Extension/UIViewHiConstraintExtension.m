//
//  UIViewHiConstraintExtension.m
//  RouterDemo
//
//  Created by four on 2020/5/18.
//  Copyright © 2020 Four. All rights reserved.
//

#import "UIViewHiConstraintExtension.h"
#import "NSObjectHiExtension.h"
#import "UIViewHiCommon.h"
#import "HiOptions.h"



@interface HiConstraint : NSObject

@property (nonatomic,strong) NSLayoutConstraint *constraint;
@property (nonatomic,weak) id contraintView; // 添加约束的 view

@end

@implementation HiConstraint

@end

@interface HiConstraintBuilder : NSObject

@property (nonatomic,assign) HiViewOptions options;
@property (nonatomic,strong) NSMutableArray<HiConstraint *> *constraints;

@end

@implementation HiConstraintBuilder
- (NSMutableArray *)constraints {
    if(!_constraints) _constraints = [NSMutableArray arrayWithCapacity:4];
    return _constraints;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _options = HiViewOptionsNone;
    }
    return self;
}

@end

@interface UIView (HiConstraintBuilder)

@property (nonatomic,readonly) HiConstraintBuilder *builder;

@end

@implementation UIView(HiConstraintBuilder)

- (HiConstraintBuilder *)builder{
    
    HiConstraintBuilder *builder = [self hi_getValueForKey:_cmd];
    if (!builder) {
        builder = [[HiConstraintBuilder alloc] init];
        [self hi_addRetainPropertyForKey:_cmd value:builder];
    }
    return builder;
}

- (void)addHiConstraint:(HiConstraint *)constraint{
    [self.builder.constraints hi_addObject:constraint];
}

- (void)creatConstraint{
    BOOL available = [HiOptions availableViewOptions:self.builder.options];
    if (available) {
        for (HiConstraint *constraint in self.builder.constraints) {
            [constraint.contraintView addConstraint:constraint.constraint];
        }
    }
    
    self.builder.options = HiViewOptionsNone;
    [self.builder.constraints removeAllObjects];
}

@end

@interface HiConstantModel ()

@property (nonatomic,weak) UIView *itemValue1;
@property (nonatomic,weak) id itemValue2;
@property (nonatomic,assign) NSLayoutAttribute attributeValue1;
@property (nonatomic,assign) NSLayoutAttribute attributeValue2;
@property (nonatomic,assign) NSLayoutRelation relationValue;
@property (nonatomic,assign) CGFloat multiplierValue;

@end

@implementation HiConstantModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _multiplierValue = 1;
    }
    return self;
}

- (NSLayoutConstraint *)constraintForConstant:(CGFloat)constant {
    NSLayoutConstraint *contraint = nil;
    
    if (self.itemValue1) {
        HiConstraint *builder = [[HiConstraint alloc] init];
        
        contraint = [NSLayoutConstraint constraintWithItem:self.itemValue1 attribute:self.attributeValue1 relatedBy:self.relationValue toItem:self.itemValue2 attribute:self.attributeValue2 multiplier:self.multiplierValue constant:constant];
        
        builder.constraint = contraint;
        
        // 约束要加在 同一个父类上
        if ([self.itemValue2 isKindOfClass:UIView.class] && [self.itemValue1 isKindOfClass:UIView.class]) {
            UIView *view1 = (UIView *)self.itemValue1;
            UIView *view2 = (UIView *)self.itemValue2;
            if ([view1.superview isEqual:view2]) {
//                [view2 addConstraint:contraint];
                builder.contraintView = view2;
            } else {
                UIView *commonSuper = [view1 commonSuperViewWithView:view2];
//                if (commonSuper) [commonSuper addConstraint:contraint];
                if (commonSuper) builder.contraintView = commonSuper;
            }
        } else if (nil == self.itemValue2 && self.itemValue1) {
            
//            [self.itemValue1 addConstraint:contraint];
            builder.contraintView = self.itemValue1;
        }
        
        [self.itemValue1 addHiConstraint:builder];
    }
    
    return contraint;
}

@end

#pragma mark ************************ HiLayoutConstantModel ************************
@implementation HiLayoutConstantModel

- (HiLayoutConstantBlock)constant {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        NSLayoutConstraint *contraint = [NSLayoutConstraint constraintWithItem:strong.itemValue1 attribute:strong.attributeValue1 relatedBy:strong.relationValue toItem:strong.itemValue2 attribute:strong.attributeValue2 multiplier:strong.multiplierValue constant:constant];
        return contraint;
    };
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong constraintForConstant:contant];
    };
}

@end


#pragma mark ************************ HiLayoutMultiplierModel ************************
@implementation HiLayoutMultiplierModel

- (HiLayoutMultiplierBlock)multiplier {
    __weak typeof(self) weak = self;
    return ^(CGFloat multiplier) {
        __strong typeof(weak) strong = weak;
        HiLayoutConstantModel *model = [[HiLayoutConstantModel alloc] init];
        model.itemValue1 = strong.itemValue1;
        model.attributeValue1 = strong.attributeValue1;
        model.relationValue = strong.relationValue;
        model.itemValue2 = strong.itemValue2;
        model.attributeValue2 = strong.attributeValue2;
        model.multiplierValue = multiplier;
        return model;
    };
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong constraintForConstant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutItemAttributeModel ************************
@implementation HiLayoutItemAttributeModel

- (HiLayoutMultiplierModel *)modelForAttribute:(NSLayoutAttribute)attribute{
    
    HiLayoutMultiplierModel *model = [[HiLayoutMultiplierModel alloc] init];
    model.itemValue1 = self.itemValue1;
    model.attributeValue1 = self.attributeValue1;
    model.relationValue = self.relationValue;
    model.itemValue2 = self.itemValue2;
    model.attributeValue2 = attribute;
    return model;
}

- (HiLayoutItemAttributeBlock)attribute {
    __weak typeof(self) weak = self;
    return ^(NSLayoutAttribute attribute) {
        __strong typeof(weak) strong = weak;
        return [strong modelForAttribute:attribute];
    };
}

- (HiLayoutMultiplierModel *)left {
    return [self modelForAttribute:NSLayoutAttributeLeft];
}

- (HiLayoutMultiplierModel *)right {
    return [self modelForAttribute:NSLayoutAttributeRight];
}

- (HiLayoutMultiplierModel *)top {
    return [self modelForAttribute:NSLayoutAttributeTop];
}

- (HiLayoutMultiplierModel *)bottom {
    return [self modelForAttribute:NSLayoutAttributeBottom];
}

- (HiLayoutMultiplierModel *)leading {
    return [self modelForAttribute:NSLayoutAttributeLeading];
}

- (HiLayoutMultiplierModel *)trailing {
    return [self modelForAttribute:NSLayoutAttributeTrailing];
}

- (HiLayoutMultiplierModel *)width {
    return [self modelForAttribute:NSLayoutAttributeHeight];
}

- (HiLayoutMultiplierModel *)height {
    return [self modelForAttribute:NSLayoutAttributeHeight];
}

- (HiLayoutMultiplierModel *)centerX {
    return [self modelForAttribute:NSLayoutAttributeCenterX];
}

- (HiLayoutMultiplierModel *)centerY {
    return [self modelForAttribute:NSLayoutAttributeCenterY];
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        strong.attributeValue2 = strong.attributeValue1;
        return [strong constraintForConstant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutItemModel ************************
@implementation HiLayoutItemModel

- (HiLayoutItemBlock)item {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemAttributeModel *model = [[HiLayoutItemAttributeModel alloc] init];
        model.itemValue1 = strong.itemValue1;
        model.attributeValue1 = strong.attributeValue1;
        model.relationValue = strong.relationValue;
        model.itemValue2 = item;
        return model;
    };
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        strong.attributeValue2 = strong.attributeValue1;
        
        BOOL notCheck = NSLayoutAttributeWidth == strong.attributeValue1 || NSLayoutAttributeHeight == strong.attributeValue1;
        
        if (!notCheck && [strong.itemValue1 isKindOfClass:UIView.class]) {
            UIView *view = (UIView *)strong.itemValue1;
            strong.itemValue2 = view.superview;
        }
        
        return [strong constraintForConstant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutRelatedModel ************************
@implementation HiLayoutRelatedModel

- (HiLayoutItemModel *)modelForRelation:(NSLayoutRelation)relation {
    HiLayoutItemModel *model = [[HiLayoutItemModel alloc] init];
    model.itemValue1 = self.itemValue1;
    model.attributeValue1 = self.attributeValue1;
    model.relationValue = relation;
    return model;
}

- (HiLayoutRelatedBlock)relate {
    __weak typeof(self) weak = self;
    return ^(NSLayoutRelation relate){
        __strong typeof(weak) strong = weak;
        return [strong modelForRelation:relate];
    };
}

- (HiLayoutItemModel *)lessThanOrEqual {
    return [self modelForRelation:NSLayoutRelationLessThanOrEqual];
}

- (HiLayoutItemModel *)equal {
    return [self modelForRelation:NSLayoutRelationEqual];
}

- (HiLayoutItemModel *)greaterThanOrEqual {
    return [self modelForRelation:NSLayoutRelationGreaterThanOrEqual];
}

@end

#pragma mark - ********** Constraint **********
@implementation UIView (HiConstraint)

- (HiLayoutRelatedModel *)modelForAttribute:(NSLayoutAttribute)attribute{
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = attribute;
    
    self.builder.options = [HiOptions viewOptions:self.builder.options forAttribute:attribute];
    return model;
}

- (HiLayoutRelatedModel *)hi_left_cs {
    return [self modelForAttribute:NSLayoutAttributeLeft];
}

- (HiLayoutRelatedModel *)hi_right_cs {
    return [self modelForAttribute:NSLayoutAttributeRight];
}

- (HiLayoutRelatedModel *)hi_top_cs {
    return [self modelForAttribute:NSLayoutAttributeTop];
}

- (HiLayoutRelatedModel *)hi_bottom_cs {
    return [self modelForAttribute:NSLayoutAttributeBottom];
}

- (HiLayoutRelatedModel *)hi_leading_cs {
    return [self modelForAttribute:NSLayoutAttributeLeading];
}

- (HiLayoutRelatedModel *)hi_trailing_cs {
    return [self modelForAttribute:NSLayoutAttributeTrailing];
}

- (HiLayoutRelatedModel *)hi_width_cs {
    return [self modelForAttribute:NSLayoutAttributeWidth];
}

- (HiLayoutRelatedModel *)hi_height_cs {
    return [self modelForAttribute:NSLayoutAttributeHeight];
}

- (HiLayoutRelatedModel *)hi_centerX_cs {
    return [self modelForAttribute:NSLayoutAttributeCenterX];
}

- (HiLayoutRelatedModel *)hi_centerY_cs {
    return [self modelForAttribute:NSLayoutAttributeCenterY];
}

- (void)hi_addConstraints:(HiConstraintBlock)block{
    
    if (block) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        block(self);
        [self creatConstraint];
    }
    block = nil;
}

@end
