//
//  UIViewHiConstraintExtension.h
//  RouterDemo
//
//  Created by four on 2020/5/18.
//  Copyright © 2020 Four. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HiLayoutBlock)(CGFloat c);

#pragma mark - constant block

@class HiLayoutMultiplierModel,
HiLayoutConstantModel;

@class HiLayoutItemVerticalAttributeModel,
HiLayoutItemVerticalModel,
HiLayoutRelatedVerticalModel;

@class HiLayoutItemHorizontalAttributeModel,
HiLayoutItemHorizontalModel,
HiLayoutRelatedHorizontalModel;

@class HiLayoutItemSizeAttributeModel,
HiLayoutItemSizeModel,
HiLayoutRelatedSizeModel;

typedef NSLayoutConstraint * _Nullable (^HiLayoutConstantBlock)(CGFloat constant);
typedef HiLayoutConstantModel * _Nullable (^HiLayoutMultiplierBlock)(CGFloat multiplier);
typedef HiLayoutMultiplierModel * _Nullable (^HiLayoutItemAttributeBlock)(NSLayoutAttribute attribute);

typedef void(^HiLayoutConstantVoidBlock)(void);

#pragma mark - block
#pragma mark ************* Vertical *************
typedef HiLayoutItemVerticalAttributeModel * _Nullable (^HiLayoutItemVerticalBlock)(id _Nullable item);
typedef HiLayoutItemVerticalModel * _Nullable (^HiLayoutRelatedVerticalBlock)(NSLayoutRelation relate);

#pragma mark ************* Horizontal *************
typedef HiLayoutItemHorizontalAttributeModel * _Nullable (^HiLayoutItemHorizontalBlock)(id _Nullable item);
typedef HiLayoutItemHorizontalModel * _Nullable (^HiLayoutRelatedHorizontalBlock)(NSLayoutRelation relate);

#pragma mark ************* Size *************
typedef HiLayoutItemSizeAttributeModel * _Nullable (^HiLayoutItemSizeBlock)(id _Nullable item);
typedef HiLayoutItemSizeModel * _Nullable (^HiLayoutRelatedSizeBlock)(NSLayoutRelation relate);

typedef void(^HiConstraintBlock)(UIView *builder);

@interface HiLayoutConstantModel : NSObject

@property (nonatomic,readonly) HiLayoutConstantBlock value;// 创建 并且 添加
@property (nonatomic,readonly) HiLayoutConstantBlock constant; // 只创建 不添加

@end

@interface HiLayoutMultiplierModel : HiLayoutConstantModel

@property (nonatomic,copy,readonly) HiLayoutMultiplierBlock multiplier;

@end


#pragma mark - ************* common *************
@interface HiLayoutRelatedModel : HiLayoutConstantModel

@property (nonatomic,readonly) HiLayoutConstantBlock lessValue;
@property (nonatomic,readonly) HiLayoutConstantBlock greatValue;

@end

#pragma mark - ************* Vertical *************
@interface HiLayoutItemVerticalAttributeModel : HiLayoutConstantModel

@property (nonatomic,readonly) HiLayoutItemAttributeBlock attribute;

@property (nonatomic,readonly) HiLayoutMultiplierModel *top;                          //上方
@property (nonatomic,readonly) HiLayoutMultiplierModel *bottom;                       //下方
@property (nonatomic,readonly) HiLayoutMultiplierModel *centerY;                      //Y轴中心

@end

@interface HiLayoutItemVerticalModel : HiLayoutConstantModel

@property (nonatomic,readonly) HiLayoutItemVerticalBlock item;

@end

@interface HiLayoutRelatedVerticalModel : HiLayoutRelatedModel

@property (nonatomic,readonly) HiLayoutRelatedVerticalBlock relate;

@property (nonatomic,readonly) HiLayoutItemVerticalBlock equal;
@property (nonatomic,readonly) HiLayoutItemVerticalBlock lessThanOrEqual;
@property (nonatomic,readonly) HiLayoutItemVerticalBlock greaterThanOrEqual;

@end

#pragma mark - ************* Horizontal *************
@interface HiLayoutItemHorizontalAttributeModel : HiLayoutConstantModel

@property (nonatomic,readonly) HiLayoutItemAttributeBlock attribute;

@property (nonatomic,readonly) HiLayoutMultiplierModel *left;                         //左侧
@property (nonatomic,readonly) HiLayoutMultiplierModel *right;                        //右侧
@property (nonatomic,readonly) HiLayoutMultiplierModel *leading;                      //首部
@property (nonatomic,readonly) HiLayoutMultiplierModel *trailing;                     //尾部
@property (nonatomic,readonly) HiLayoutMultiplierModel *centerX;                      //X轴中心

@end

@interface HiLayoutItemHorizontalModel : HiLayoutConstantModel

@property (nonatomic,readonly) HiLayoutItemHorizontalBlock item;

@end

@interface HiLayoutRelatedHorizontalModel : HiLayoutRelatedModel

@property (nonatomic,readonly) HiLayoutRelatedHorizontalBlock relate;

@property (nonatomic,readonly) HiLayoutItemHorizontalBlock equal;
@property (nonatomic,readonly) HiLayoutItemHorizontalBlock lessThanOrEqual;
@property (nonatomic,readonly) HiLayoutItemHorizontalBlock greaterThanOrEqual;

@end

#pragma mark - ************* Size *************
@interface HiLayoutItemSizeAttributeModel : HiLayoutConstantModel

@property (nonatomic,readonly) HiLayoutItemAttributeBlock attribute;
@property (nonatomic,readonly) HiLayoutMultiplierModel *width;                        //宽度
@property (nonatomic,readonly) HiLayoutMultiplierModel *height;                       //高度

@end

@interface HiLayoutItemSizeModel : HiLayoutConstantModel

@property (nonatomic,readonly) HiLayoutItemSizeBlock item;

/** 除了 width height 之外, 都是 相对 super view */
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutRelatedSizeModel : HiLayoutRelatedModel

@property (nonatomic,readonly) HiLayoutRelatedSizeBlock relate;

@property (nonatomic,readonly) HiLayoutItemSizeBlock equal;
@property (nonatomic,readonly) HiLayoutItemSizeBlock lessThanOrEqual;
@property (nonatomic,readonly) HiLayoutItemSizeBlock greaterThanOrEqual;
@property (nonatomic,readonly) HiLayoutConstantVoidBlock autoValue;

@end

#pragma mark - ************* Constraint *************

typedef NSLayoutConstraint * _Nullable (^HiConstraintAttributeBlock)(NSLayoutAttribute attribute);
@interface UIView (HiConstraint)

@property (nonatomic,readonly) HiLayoutRelatedHorizontalModel *hi_left;                         //左侧
@property (nonatomic,readonly) HiLayoutRelatedHorizontalModel *hi_right;                        //右侧
@property (nonatomic,readonly) HiLayoutRelatedVerticalModel *hi_top;                          //上方
@property (nonatomic,readonly) HiLayoutRelatedVerticalModel *hi_bottom;                       //下方
@property (nonatomic,readonly) HiLayoutRelatedHorizontalModel *hi_leading;                      //首部
@property (nonatomic,readonly) HiLayoutRelatedHorizontalModel *hi_trailing;                     //尾部
@property (nonatomic,readonly) HiLayoutRelatedSizeModel *hi_width;                        //宽度
@property (nonatomic,readonly) HiLayoutRelatedSizeModel *hi_height;                       //高度
@property (nonatomic,readonly) HiLayoutRelatedHorizontalModel *hi_centerX;                      //X轴中心
@property (nonatomic,readonly) HiLayoutRelatedVerticalModel *hi_centerY;                      //Y轴中心

@property (nonatomic,readonly) HiConstraintAttributeBlock hi_update;
@property (nonatomic,readonly) HiConstraintAttributeBlock hi_remove;

- (void)hi_addConstraints:(HiConstraintBlock)block;

@end

NS_ASSUME_NONNULL_END
