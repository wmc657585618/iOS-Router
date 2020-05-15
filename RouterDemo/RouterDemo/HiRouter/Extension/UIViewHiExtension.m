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

@end

#pragma mark ************************ HiLayoutConstantModel ************************
@implementation HiLayoutConstantModel

- (HiLayoutConstantBlock)constant {
    __weak typeof(self) weak = self;
    return ^(CGFloat constant) {
        __strong typeof(weak) strong = weak;
        return [NSLayoutConstraint constraintWithItem:strong.itemValue1 attribute:strong.attributeValue1 relatedBy:strong.relationValue toItem:strong.itemValue2 attribute:strong.attributeValue2 multiplier:strong.multiplierValue constant:constant];
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

- (HiLayoutItemAttributeBlock)attribute {
    __weak typeof(self) weak = self;
    return ^(NSLayoutAttribute attribute) {
        __strong typeof(weak) strong = weak;
        HiLayoutMultiplierModel *model = [[HiLayoutMultiplierModel alloc] init];
        model.attributeValue1 = strong.attributeValue1;
        model.relationValue = strong.relationValue;
        model.itemValue2 = strong.itemValue2;
        model.attributeValue2 = attribute;
        return model;
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
        model.attributeValue1 = strong.attributeValue1;
        model.relationValue = strong.relationValue;
        model.itemValue2 = item;
        return model;
    };
}

@end

#pragma mark ************************ HiLayoutRelatedModel ************************
@implementation HiLayoutRelatedModel

- (HiLayoutRelatedBlock)relate {
    __weak typeof(self) weak = self;
    return ^(NSLayoutRelation relate){
        __strong typeof(weak) strong = weak;
        HiLayoutItemModel *model = [[HiLayoutItemModel alloc] init];
        model.attributeValue1 = strong.attributeValue1;
        model.relationValue = relate;
        return model;
    };
}

- (HiLayoutItemModel *)lessThanOrEqual {

    HiLayoutItemModel *model = [[HiLayoutItemModel alloc] init];
    model.attributeValue1 = self.attributeValue1;
    model.relationValue = NSLayoutRelationLessThanOrEqual;
    return model;
}

- (HiLayoutItemModel *)equal {
    
    HiLayoutItemModel *model = [[HiLayoutItemModel alloc] init];
    model.attributeValue1 = self.attributeValue1;
    model.relationValue = NSLayoutRelationEqual;
    return model;
}

- (HiLayoutItemModel *)greaterThanOrEqual {
    
    HiLayoutItemModel *model = [[HiLayoutItemModel alloc] init];
    model.attributeValue1 = self.attributeValue1;
    model.relationValue = NSLayoutRelationGreaterThanOrEqual;
    return model;
}

@end

#pragma mark ************************ HiLayoutAttributeModel ************************
@implementation HiLayoutAttributeModel

- (HiLayoutAttributeBlock)attribute {
    
    return ^(NSLayoutAttribute attribute) {
        HiLayoutRelatedModel *model = [[HiLayoutRelatedModel alloc] init];
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
    SEL sel = @selector(hi_left_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeLeft;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_right_cs {
    SEL sel = @selector(hi_right_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeRight;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_top_cs {
    SEL sel = @selector(hi_top_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeTop;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_bottom_cs {
    SEL sel = @selector(hi_bottom_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeBottom;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_leading_cs {
    SEL sel = @selector(hi_leading_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeLeading;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_trailing_cs {
    SEL sel = @selector(hi_trailing_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeTrailing;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_width_cs {
    SEL sel = @selector(hi_width_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeWidth;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_height_cs {
    SEL sel = @selector(hi_height_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeHeight;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_centerX_cs {
    SEL sel = @selector(hi_centerX_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeCenterX;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}

- (HiLayoutRelatedModel *)hi_centerY_cs {
    SEL sel = @selector(hi_centerY_cs);
    HiLayoutRelatedModel *model = [self hi_getValueForKey:sel];
    if (!model) {
        model = [[HiLayoutRelatedModel alloc] init];
        model.itemValue1 = self;
        model.attributeValue1 = NSLayoutAttributeCenterY;
        [self hi_addRetainPropertyForKey:sel value:model];
    }
    return model;
}
@end
