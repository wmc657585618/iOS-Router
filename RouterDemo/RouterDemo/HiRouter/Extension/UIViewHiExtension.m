//
//  UIViewHiExtension.m
//  RouterDemo
//
//  Created by four on 2020/5/14.
//  Copyright © 2020 Four. All rights reserved.
//

#import "UIViewHiExtension.h"
#import "NSObjectHiExtension.h"

@interface HiLayoutModel ()

@property (nonatomic,assign) CGFloat multiplierValue; // default is 1.
@property (nonatomic,assign) CGFloat constantValue; // default is 0.
@end
@implementation HiLayoutModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _multiplierValue = 1;
    }
    return self;
}

- (HiLayoutBlock)multiplier {
    __weak typeof(self) weak = self;
    return ^(CGFloat mul) {
        __strong typeof(weak) strong = weak;
        strong.multiplierValue = mul;
    };
}

- (HiLayoutBlock)constant {
    __weak typeof(self) weak = self;
    return ^(CGFloat con) {
        __strong typeof(weak) strong = weak;
        strong.constantValue = con;
    };
}

@end

#pragma mark - constant

@implementation UIView (HiCommonSuper)

// 获取所有父类
- (NSArray *)superViews {
    UIView *view = self.superview;
    
    if (!view)return @[];
    
    NSMutableArray *result = [NSMutableArray array];
    while (view) {
        [result addObject:view];
        view = view.superview;
    }
    return result;
}

- (UIView *)commonSuperViewWithView:(UIView *)view {
    NSArray *arr1 = [self superViews];
    NSArray *arr2 = [view superViews];
    NSSet *set = [NSSet setWithArray:arr2];
    for (NSUInteger i = 0; i < arr1.count; ++i) {
        UIView *targetView = arr1[i];
        if ([set containsObject:targetView]) return targetView;
    }
    return nil;
}

@end
@interface HiConstantModel ()

@property (nonatomic,weak) id itemValue1;
@property (nonatomic,weak) id itemValue2;
@property (nonatomic,assign) NSLayoutAttribute attributeValue1;
@property (nonatomic,assign) NSLayoutAttribute attributeValue2;
@property (nonatomic,assign) NSLayoutRelation relationValue;
@property (nonatomic,assign) CGFloat multiplierValue;
@property (nonatomic,assign) CGFloat constantValue;

@end

@implementation HiConstantModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _multiplierValue = 1;
        _constantValue = 0;
    }
    return self;
}

- (NSLayoutConstraint *)constraintForConstant:(CGFloat)constant {
    NSLayoutConstraint *contraint = nil;
    
    if (self.itemValue1) {
        contraint = [NSLayoutConstraint constraintWithItem:self.itemValue1 attribute:self.attributeValue1 relatedBy:self.relationValue toItem:self.itemValue2 attribute:self.attributeValue2 multiplier:self.multiplierValue constant:constant];
        
        // 约束要加在 同一个父类上
        if ([self.itemValue2 isKindOfClass:UIView.class] && [self.itemValue1 isKindOfClass:UIView.class]) {
            UIView *view1 = (UIView *)self.itemValue1;
            UIView *view2 = (UIView *)self.itemValue2;
            if ([view1.superview isEqual:view2]) {
                [view2 addConstraint:contraint];
            } else {
                UIView *commonSuper = [view1 commonSuperViewWithView:view2];
                if (commonSuper) [commonSuper addConstraint:contraint];
            }
        } else if (nil == self.itemValue2 && self.itemValue1) {
            
            [self.itemValue1 addConstraint:contraint];
        }
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
        NSLayoutConstraint *contraint = nil;
        
        if (strong.itemValue2 && strong.itemValue1) {
            
            contraint = [NSLayoutConstraint constraintWithItem:strong.itemValue1 attribute:strong.attributeValue1 relatedBy:strong.relationValue toItem:strong.itemValue2 attribute:strong.attributeValue2 multiplier:strong.multiplierValue constant:constant];
            
        }
        return contraint;
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

#pragma mark ************************ HiLayoutAttributeModel ************************
@implementation HiLayoutAttributeModel

- (HiLayoutAttributeBlock)attribute {
    
    __weak typeof(self) weak = self;
    return ^(NSLayoutAttribute attribute) {
        __strong typeof(weak) strong = weak;
        HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = strong.itemValue1;
        model.attributeValue1 = attribute;
        return model;
    };
}

@end

#pragma mark - view

@implementation UIView (HiCategory)

- (HiLayoutModel *)hi_left {
    SEL sel = @selector(hi_left);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_right {
    SEL sel = @selector(hi_right);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_top {
    SEL sel = @selector(hi_top);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_bottom {
    SEL sel = @selector(hi_bottom);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_leading {
    SEL sel = @selector(hi_leading);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_trailing {
    SEL sel = @selector(hi_trailing);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_width {
    SEL sel = @selector(hi_width);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_height {
    SEL sel = @selector(hi_height);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_centerX {
    SEL sel = @selector(hi_centerX);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutModel *)hi_centerY {
    SEL sel = @selector(hi_centerY);
    HiLayoutModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutModel alloc] init];
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

@end

@implementation UIView (HiConstraint)

- (HiLayoutRelatedModel *)hi_left_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeLeft;
    return model;
}

- (HiLayoutRelatedModel *)hi_right_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeRight;
    return model;
}

- (HiLayoutRelatedModel *)hi_top_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeTop;
    return model;
}

- (HiLayoutRelatedModel *)hi_bottom_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeBottom;
    return model;
}

- (HiLayoutRelatedModel *)hi_leading_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeLeading;
    return model;
}

- (HiLayoutRelatedModel *)hi_trailing_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeTrailing;
    return model;
}

- (HiLayoutRelatedModel *)hi_width_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeWidth;
    return model;
}

- (HiLayoutRelatedModel *)hi_height_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeHeight;
    return model;
}

- (HiLayoutRelatedModel *)hi_centerX_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeCenterX;
    return model;
}

- (HiLayoutRelatedModel *)hi_centerY_cs {
    HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
    model.itemValue1 = self;
    model.attributeValue1 = NSLayoutAttributeCenterY;
    return model;
}

- (void)hi_addConstraints:(HiConstraintBlock)block{
    
    if (block) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        block(self);
    }
    block = nil;
}

@end
