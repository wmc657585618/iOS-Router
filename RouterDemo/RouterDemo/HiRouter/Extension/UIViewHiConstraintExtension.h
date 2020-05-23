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

@interface HiConstantModel : NSObject

@end

@interface HiLayoutConstantModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutConstantBlock constant; // 只创建 不添加
@property (nonatomic,copy,readonly) HiLayoutConstantBlock value; // 创建 并且 添加

@end

@interface HiLayoutMultiplierModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutMultiplierBlock multiplier;
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end


#pragma mark - ************* common *************
@interface HiLayoutRelatedModel : HiConstantModel

/** 除了 width height 之外, 都是 相对 super view */
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

#pragma mark - ************* Vertical *************
@interface HiLayoutItemVerticalAttributeModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutItemAttributeBlock attribute;

@property (nonatomic,readonly) HiLayoutMultiplierModel *top;                          //上方
@property (nonatomic,readonly) HiLayoutMultiplierModel *bottom;                       //下方
@property (nonatomic,readonly) HiLayoutMultiplierModel *centerY;                      //Y轴中心

/** item2 的 NSLayoutAttribute 和 item1 相同*/
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutItemVerticalModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutItemVerticalBlock item;

/** 除了 width height 之外, 都是 相对 super view */
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutRelatedVerticalModel : HiLayoutRelatedModel

@property (nonatomic,readonly) HiLayoutRelatedVerticalBlock relate;

@property (nonatomic,readonly) HiLayoutItemVerticalModel *equal;
@property (nonatomic,readonly) HiLayoutItemVerticalModel *lessThanOrEqual;
@property (nonatomic,readonly) HiLayoutItemVerticalModel *greaterThanOrEqual;

@end

#pragma mark - ************* Horizontal *************
@interface HiLayoutItemHorizontalAttributeModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutItemAttributeBlock attribute;

@property (nonatomic,readonly) HiLayoutMultiplierModel *left;                         //左侧
@property (nonatomic,readonly) HiLayoutMultiplierModel *right;                        //右侧
@property (nonatomic,readonly) HiLayoutMultiplierModel *leading;                      //首部
@property (nonatomic,readonly) HiLayoutMultiplierModel *trailing;                     //尾部
@property (nonatomic,readonly) HiLayoutMultiplierModel *centerX;                      //X轴中心

/** item2 的 NSLayoutAttribute 和 item1 相同*/
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutItemHorizontalModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutItemHorizontalBlock item;

/** 除了 width height 之外, 都是 相对 super view */
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutRelatedHorizontalModel : HiLayoutRelatedModel

@property (nonatomic,readonly) HiLayoutRelatedHorizontalBlock relate;

@property (nonatomic,readonly) HiLayoutItemHorizontalModel *equal;
@property (nonatomic,readonly) HiLayoutItemHorizontalModel *lessThanOrEqual;
@property (nonatomic,readonly) HiLayoutItemHorizontalModel *greaterThanOrEqual;

@end

#pragma mark - ************* Size *************
@interface HiLayoutItemSizeAttributeModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutItemAttributeBlock attribute;
@property (nonatomic,readonly) HiLayoutMultiplierModel *width;                        //宽度
@property (nonatomic,readonly) HiLayoutMultiplierModel *height;                       //高度

/** item2 的 NSLayoutAttribute 和 item1 相同*/
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutItemSizeModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutItemSizeBlock item;

/** 除了 width height 之外, 都是 相对 super view */
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutRelatedSizeModel : HiLayoutRelatedModel

@property (nonatomic,readonly) HiLayoutRelatedSizeBlock relate;

@property (nonatomic,readonly) HiLayoutItemSizeModel *equal;
@property (nonatomic,readonly) HiLayoutItemSizeModel *lessThanOrEqual;
@property (nonatomic,readonly) HiLayoutItemSizeModel *greaterThanOrEqual;
@property (nonatomic,readonly) HiLayoutConstantVoidBlock autoValue;

@end

#pragma mark - ************* Constraint *************

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

- (void)hi_addConstraints:(HiConstraintBlock)block;

@end

NS_ASSUME_NONNULL_END
