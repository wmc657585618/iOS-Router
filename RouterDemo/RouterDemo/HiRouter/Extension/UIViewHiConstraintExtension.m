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


#pragma mark - Common
@interface HiConstraint : NSObject

@property (nonatomic,strong) NSLayoutConstraint *constraint;
@property (nonatomic,weak) id contraintView; // 添加约束的 view

@end

@implementation HiConstraint

@end

@interface HiConstraintBuilder : NSObject

@property (nonatomic,assign) HiViewOptions options;
@property (nonatomic,strong) NSMutableArray<HiConstraint *> *constraints;

@property (nonatomic,strong) HiConstraint *constraintL;
@property (nonatomic,strong) HiConstraint *constraintR;
@property (nonatomic,strong) HiConstraint *constraintT;
@property (nonatomic,strong) HiConstraint *constraintB;
@property (nonatomic,strong) HiConstraint *constraintW;
@property (nonatomic,strong) HiConstraint *constraintH;
@property (nonatomic,strong) HiConstraint *constraintCX;
@property (nonatomic,strong) HiConstraint *constraintCY;

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

- (HiConstraint *)hi_constrainForAttribute:(NSLayoutAttribute)attribute{
    switch (attribute) {
        case NSLayoutAttributeLeft:
            return self.builder.constraintL;
            
        case NSLayoutAttributeRight:
            return self.builder.constraintR;
            
        case NSLayoutAttributeTop:
            return self.builder.constraintT;

        case NSLayoutAttributeBottom:
            return self.builder.constraintB;

        case NSLayoutAttributeLeading:
            return self.builder.constraintL;

        case NSLayoutAttributeTrailing:
            return self.builder.constraintT;

        case NSLayoutAttributeWidth:
            return self.builder.constraintW;

        case NSLayoutAttributeHeight:
            return self.builder.constraintH;

        case NSLayoutAttributeCenterX:
            return self.builder.constraintCX;

        case NSLayoutAttributeCenterY:
            return self.builder.constraintCY;
            
        default:
            return nil;
    }
}

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute {
    return [self hi_constrainForAttribute:attribute].constraint;
}

- (void)addConstraint:(HiConstraint *)constraint attribute:(NSLayoutAttribute)attribute{
    
    switch (attribute) {
        case NSLayoutAttributeLeft:
            self.builder.constraintL = constraint;
            break;
            
        case NSLayoutAttributeRight:
            self.builder.constraintR = constraint;
            break;
            
        case NSLayoutAttributeTop:
            self.builder.constraintT = constraint;
            break;

        case NSLayoutAttributeBottom:
            self.builder.constraintB = constraint;
            break;

        case NSLayoutAttributeLeading:
            self.builder.constraintL = constraint;
            break;

        case NSLayoutAttributeTrailing:
            self.builder.constraintT = constraint;
            break;

        case NSLayoutAttributeWidth:
            self.builder.constraintW = constraint;
            break;

        case NSLayoutAttributeHeight:
            self.builder.constraintH = constraint;
            break;

        case NSLayoutAttributeCenterX:
            self.builder.constraintCX = constraint;
            break;

        case NSLayoutAttributeCenterY:
            self.builder.constraintCY = constraint;
            break;
            
        default:
            break;
    }
}

- (NSLayoutConstraint *)removeConstrainForAttribute:(NSLayoutAttribute)attribute{
    HiConstraint *constraint = [self hi_constrainForAttribute:attribute];
    NSLayoutConstraint *c = constraint.constraint;
    [constraint.contraintView removeConstraint:c];
    [self addConstraint:nil attribute:attribute];

    return c;
}

@end

#pragma mark ************************ HiLayoutConstantModel ************************
@interface HiLayoutConstantModel ()

@property (nonatomic,weak) UIView *itemValue1;
@property (nonatomic,weak) id itemValue2;
@property (nonatomic,assign) NSLayoutAttribute attributeValue1;
@property (nonatomic,assign) NSLayoutAttribute attributeValue2;
@property (nonatomic,assign) NSLayoutRelation relationValue;
@property (nonatomic,assign) CGFloat multiplierValue;

@end

@implementation HiLayoutConstantModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _multiplierValue = 1;
    }
    return self;
}

- (NSLayoutConstraint *)valueForConstant:(CGFloat)constant {
    NSLayoutConstraint *contraint = nil;
    
    if (self.itemValue1) {
        HiConstraint *builder = [[HiConstraint alloc] init];
        
        contraint = [self constraintForConstant:constant];
        
        builder.constraint = contraint;
        
        // 约束要加在 同一个父类上
        if ([self.itemValue2 isKindOfClass:UIView.class]) {
            UIView *view1 = self.itemValue1;
            UIView *view2 = (UIView *)self.itemValue2;
            if ([view1.superview isEqual:view2]) {
                builder.contraintView = view2;
            } else {
                builder.contraintView = [view1 commonSuperViewWithView:view2];
            }
        } else if (nil == self.itemValue2 && self.itemValue1) {
            
            builder.contraintView = self.itemValue1;
        } else {
            // 不添加
            return contraint;
        }
        self.itemValue1.builder.options = [HiOptions viewOptions:self.itemValue1.builder.options forAttribute:self.attributeValue1];
        [self.itemValue1 addConstraint:builder attribute:self.attributeValue1];
        [self.itemValue1 addHiConstraint:builder];
    }
    
    return contraint;
}

- (NSLayoutConstraint *)constraintForConstant:(CGFloat)constant {
    return [NSLayoutConstraint constraintWithItem:self.itemValue1 attribute:self.attributeValue1 relatedBy:self.relationValue toItem:self.itemValue2 attribute:self.attributeValue2 multiplier:self.multiplierValue constant:constant];;
}

- (void)propertyForModel:(HiLayoutConstantModel *)model{
    model.itemValue1 = self.itemValue1;
    model.itemValue2 = self.itemValue2;
    model.attributeValue1 = self.attributeValue1;
    model.attributeValue2 = self.attributeValue2;
    model.relationValue = self.relationValue;
    model.multiplierValue = self.multiplierValue;
}

- (BOOL)isSizeModelForAttribute:(NSLayoutAttribute)attribute {
    return NSLayoutAttributeWidth == attribute || NSLayoutAttributeHeight == attribute;
}

// 设置 自己的 x y w h ...
- (NSLayoutConstraint *)selfValueForContant:(CGFloat)constant {
    self.attributeValue2 = self.attributeValue1;
    if (![self isSizeModelForAttribute:self.attributeValue1]) {
        self.itemValue2 = self.itemValue1.superview;
    }
    
    return [self valueForConstant:constant];
}

- (NSLayoutConstraint *)selfConstraintForContant:(CGFloat)constant {
    self.attributeValue2 = self.attributeValue1;
    if (![self isSizeModelForAttribute:self.attributeValue1]) {
        self.itemValue2 = self.itemValue1.superview;
    }
    
    return [self constraintForConstant:constant];
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong valueForConstant:contant];
    };
}

- (HiLayoutConstantBlock)constant {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        return [strong constraintForConstant:constant];
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
        [strong propertyForModel:model];
        model.multiplierValue = multiplier;
        return model;
    };
}

@end

@implementation HiLayoutRelatedModel

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong selfValueForContant:contant];
    };
}

- (HiLayoutConstantBlock)constant {
    
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong selfConstraintForContant:contant];
    };
}


- (HiLayoutConstantBlock)greatValue {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        strong.relationValue = NSLayoutRelationGreaterThanOrEqual;
        return [strong selfValueForContant:constant];
    };
}

- (HiLayoutConstantBlock)lessValue {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        strong.relationValue = NSLayoutRelationLessThanOrEqual;
        return [strong selfValueForContant:constant];
    };
}

@end

#pragma mark - ************* Vertical *************
@implementation HiLayoutItemVerticalAttributeModel

- (HiLayoutMultiplierModel *)modelForAttribute:(NSLayoutAttribute)attribute{
    
    HiLayoutMultiplierModel *model = [[HiLayoutMultiplierModel alloc] init];
    [self propertyForModel:model];
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

- (HiLayoutMultiplierModel *)top {
    return [self modelForAttribute:NSLayoutAttributeTop];
}

- (HiLayoutMultiplierModel *)bottom {
    return [self modelForAttribute:NSLayoutAttributeBottom];
}

- (HiLayoutMultiplierModel *)centerY {
    return [self modelForAttribute:NSLayoutAttributeCenterY];
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        strong.attributeValue2 = strong.attributeValue1;
        return [strong valueForConstant:contant];
    };
}

- (HiLayoutConstantBlock)constant {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        strong.attributeValue2 = strong.attributeValue1;
        return [strong constraintForConstant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutItemModel ************************
@implementation HiLayoutItemVerticalModel

- (HiLayoutItemVerticalBlock)item {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemVerticalAttributeModel *model = [[HiLayoutItemVerticalAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        return model;
    };
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong selfValueForContant:contant];
    };
}

- (HiLayoutConstantBlock)constant {
    
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong selfConstraintForContant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutRelatedModel ************************
@implementation HiLayoutRelatedVerticalModel

- (HiLayoutItemVerticalModel *)modelForRelation:(NSLayoutRelation)relation {
    HiLayoutItemVerticalModel *model = [[HiLayoutItemVerticalModel alloc] init];
    [self propertyForModel:model];
    model.relationValue = relation;
    return model;
}

- (HiLayoutRelatedVerticalBlock)relate {
    __weak typeof(self) weak = self;
    return ^(NSLayoutRelation relate){
        __strong typeof(weak) strong = weak;
        return [strong modelForRelation:relate];
    };
}

- (HiLayoutItemVerticalBlock)lessThanOrEqual {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemVerticalAttributeModel *model = [[HiLayoutItemVerticalAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationLessThanOrEqual;
        return model;
    };
}

- (HiLayoutItemVerticalBlock)equal {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemVerticalAttributeModel *model = [[HiLayoutItemVerticalAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationEqual;
        return model;
    };
}

- (HiLayoutItemVerticalBlock)greaterThanOrEqual {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemVerticalAttributeModel *model = [[HiLayoutItemVerticalAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationGreaterThanOrEqual;
        return model;
    };
}

@end

#pragma mark - ************* Horizontal *************
@implementation HiLayoutItemHorizontalAttributeModel

- (HiLayoutMultiplierModel *)modelForAttribute:(NSLayoutAttribute)attribute{
    
    HiLayoutMultiplierModel *model = [[HiLayoutMultiplierModel alloc] init];
    [self propertyForModel:model];
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

- (HiLayoutMultiplierModel *)leading {
    return [self modelForAttribute:NSLayoutAttributeLeading];
}

- (HiLayoutMultiplierModel *)trailing {
    return [self modelForAttribute:NSLayoutAttributeTrailing];
}

- (HiLayoutMultiplierModel *)centerX {
    return [self modelForAttribute:NSLayoutAttributeCenterX];
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        strong.attributeValue2 = strong.attributeValue1;
        return [strong valueForConstant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutItemModel ************************
@implementation HiLayoutItemHorizontalModel

- (HiLayoutItemHorizontalBlock)item {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemHorizontalAttributeModel *model = [[HiLayoutItemHorizontalAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        return model;
    };
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong selfValueForContant:contant];
    };
}

- (HiLayoutConstantBlock)constant {
    
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong selfConstraintForContant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutRelatedModel ************************
@implementation HiLayoutRelatedHorizontalModel

- (HiLayoutItemHorizontalModel *)modelForRelation:(NSLayoutRelation)relation {
    HiLayoutItemHorizontalModel *model = [[HiLayoutItemHorizontalModel alloc] init];
    model.itemValue1 = self.itemValue1;
    model.attributeValue1 = self.attributeValue1;
    model.relationValue = relation;
    return model;
}

- (HiLayoutRelatedHorizontalBlock)relate {
    __weak typeof(self) weak = self;
    return ^(NSLayoutRelation relate){
        __strong typeof(weak) strong = weak;
        return [strong modelForRelation:relate];
    };
}

- (HiLayoutItemHorizontalBlock)lessThanOrEqual {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemHorizontalAttributeModel *model = [[HiLayoutItemHorizontalAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationLessThanOrEqual;
        return model;
    };
}

- (HiLayoutItemHorizontalBlock)equal {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemHorizontalAttributeModel *model = [[HiLayoutItemHorizontalAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationEqual;
        return model;
    };
}

- (HiLayoutItemHorizontalBlock)greaterThanOrEqual {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemHorizontalAttributeModel *model = [[HiLayoutItemHorizontalAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationGreaterThanOrEqual;
        return model;
    };
}

@end

#pragma mark - ************* Size *************
@implementation HiLayoutItemSizeAttributeModel

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

- (HiLayoutMultiplierModel *)width {
    return [self modelForAttribute:NSLayoutAttributeWidth];
}

- (HiLayoutMultiplierModel *)height {
    return [self modelForAttribute:NSLayoutAttributeHeight];
}

- (HiLayoutConstantBlock)value {
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        strong.attributeValue2 = strong.attributeValue1;
        return [strong valueForConstant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutItemModel ************************
@implementation HiLayoutItemSizeModel

- (HiLayoutItemSizeBlock)item {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemSizeAttributeModel *model = [[HiLayoutItemSizeAttributeModel alloc] init];
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
        return [strong selfValueForContant:contant];
    };
}

- (HiLayoutConstantBlock)constant {
    
    __weak typeof(self) weak = self;
    return ^(CGFloat contant) {
        __strong typeof(weak) strong = weak;
        return [strong selfConstraintForContant:contant];
    };
}

@end

#pragma mark ************************ HiLayoutRelatedModel ************************
@implementation HiLayoutRelatedSizeModel

- (HiLayoutItemSizeModel *)modelForRelation:(NSLayoutRelation)relation {
    HiLayoutItemSizeModel *model = [[HiLayoutItemSizeModel alloc] init];
    [self propertyForModel:model];
    model.relationValue = relation;
    return model;
}

- (HiLayoutRelatedSizeBlock)relate {
    __weak typeof(self) weak = self;
    return ^(NSLayoutRelation relate){
        __strong typeof(weak) strong = weak;
        return [strong modelForRelation:relate];
    };
}

- (HiLayoutItemSizeBlock)equal {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemSizeAttributeModel *model = [[HiLayoutItemSizeAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationEqual;
        return model;
    };
}

- (HiLayoutItemSizeBlock)lessThanOrEqual {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemSizeAttributeModel *model = [[HiLayoutItemSizeAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationLessThanOrEqual;
        return model;
    };
}

- (HiLayoutItemSizeBlock)greaterThanOrEqual {
    __weak typeof(self) weak = self;
    return ^(id item) {
        __strong typeof(weak) strong = weak;
        HiLayoutItemSizeAttributeModel *model = [[HiLayoutItemSizeAttributeModel alloc] init];
        [strong propertyForModel:model];
        model.itemValue2 = item;
        model.relationValue = NSLayoutRelationGreaterThanOrEqual;
        return model;
    };
}

- (HiLayoutConstantVoidBlock)autoValue {
    // 记录一下
    __weak typeof(self) weak = self;
    return ^{
        __strong typeof(weak) strong = weak;
        strong.itemValue1.builder.options = [HiOptions viewOptions:strong.itemValue1.builder.options forAttribute:strong.attributeValue1];
    };
}

@end


#pragma mark - ********** Constraint **********
@implementation UIView (HiConstraint)

- (void)setModel:(HiLayoutConstantModel *)model attribute:(NSLayoutAttribute)attribute {
    model.itemValue1 = self;
    model.attributeValue1 = attribute;
}

- (HiLayoutRelatedHorizontalModel *)horizontalModelForAttribute:(NSLayoutAttribute)attribute{
    HiLayoutRelatedHorizontalModel *model = [[HiLayoutRelatedHorizontalModel alloc] init];
    [self setModel:model attribute:attribute];
    return model;
}

- (HiLayoutRelatedVerticalModel *)verticalModelForAttribute:(NSLayoutAttribute)attribute{
    HiLayoutRelatedVerticalModel *model = [[HiLayoutRelatedVerticalModel alloc] init];
    [self setModel:model attribute:attribute];
    return model;
}

- (HiLayoutRelatedSizeModel *)sizeModelForAttribute:(NSLayoutAttribute)attribute{
    HiLayoutRelatedSizeModel *model = [[HiLayoutRelatedSizeModel alloc] init];
    [self setModel:model attribute:attribute];
    return model;
}

- (HiLayoutRelatedHorizontalModel *)hi_left {
    return [self horizontalModelForAttribute:NSLayoutAttributeLeft];
}

- (HiLayoutRelatedHorizontalModel *)hi_right {
    return [self horizontalModelForAttribute:NSLayoutAttributeRight];
}

- (HiLayoutRelatedVerticalModel *)hi_top {
    return [self verticalModelForAttribute:NSLayoutAttributeTop];
}

- (HiLayoutRelatedVerticalModel *)hi_bottom {
    return [self verticalModelForAttribute:NSLayoutAttributeBottom];
}

- (HiLayoutRelatedHorizontalModel *)hi_leading {
    return [self horizontalModelForAttribute:NSLayoutAttributeLeading];
}

- (HiLayoutRelatedHorizontalModel *)hi_trailing {
    return [self horizontalModelForAttribute:NSLayoutAttributeTrailing];
}

- (HiLayoutRelatedSizeModel *)hi_width {
    return [self sizeModelForAttribute:NSLayoutAttributeWidth];
}

- (HiLayoutRelatedSizeModel *)hi_height {
    return [self sizeModelForAttribute:NSLayoutAttributeHeight];
}

- (HiLayoutRelatedHorizontalModel *)hi_centerX {
    return [self horizontalModelForAttribute:NSLayoutAttributeCenterX];
}

- (HiLayoutRelatedVerticalModel *)hi_centerY {
    return [self verticalModelForAttribute:NSLayoutAttributeCenterY];
}

- (void)hi_addConstraints:(HiConstraintBlock)block{
    
    if (block) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        block(self);
        [self creatConstraint];
    }
    block = nil;
}

- (HiConstraintAttributeBlock)hi_update {
    __weak typeof(self) weak = self;
    return ^(NSLayoutAttribute attribute) {
        __strong typeof(weak) strong = weak;
        return [strong constraintForAttribute:attribute];
    };
}

- (HiConstraintAttributeBlock)hi_remove {
    __weak typeof(self) weak = self;
    return ^(NSLayoutAttribute attribute) {
        __strong typeof(weak) strong = weak;
        return [strong removeConstrainForAttribute:attribute];
    };
}

@end
