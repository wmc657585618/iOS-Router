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

@class HiLayoutAttributeModel,
HiLayoutRelatedModel,
HiLayoutItemModel,
HiLayoutItemAttributeModel,
HiLayoutMultiplierModel,
HiLayoutConstantModel;

typedef NSLayoutConstraint * _Nullable (^HiLayoutConstantBlock)(CGFloat constant);
typedef HiLayoutConstantModel * _Nullable (^HiLayoutMultiplierBlock)(CGFloat multiplier);
typedef HiLayoutMultiplierModel * _Nullable (^HiLayoutItemAttributeBlock)(NSLayoutAttribute attribute);
typedef HiLayoutItemAttributeModel * _Nullable (^HiLayoutItemBlock)(id _Nullable item);
typedef HiLayoutItemModel * _Nullable (^HiLayoutRelatedBlock)(NSLayoutRelation relate);
typedef HiLayoutRelatedModel * _Nullable (^HiLayoutAttributeBlock)(NSLayoutAttribute attribute);

typedef void(^HiConstraintBlock)(UIView * _Nonnull hivcs);

@interface HiConstantModel : NSObject

@end

@interface HiLayoutConstantModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutConstantBlock constant;

@end

@interface HiLayoutMultiplierModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutMultiplierBlock multiplier;

@end

@interface HiLayoutItemAttributeModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutItemAttributeBlock attribute;

@property (nonatomic,readonly) HiLayoutMultiplierModel *left;                         //左侧
@property (nonatomic,readonly) HiLayoutMultiplierModel *right;                        //右侧
@property (nonatomic,readonly) HiLayoutMultiplierModel *top;                          //上方
@property (nonatomic,readonly) HiLayoutMultiplierModel *bottom;                       //下方
@property (nonatomic,readonly) HiLayoutMultiplierModel *leading;                      //首部
@property (nonatomic,readonly) HiLayoutMultiplierModel *trailing;                     //尾部
@property (nonatomic,readonly) HiLayoutMultiplierModel *width;                        //宽度
@property (nonatomic,readonly) HiLayoutMultiplierModel *height;                       //高度
@property (nonatomic,readonly) HiLayoutMultiplierModel *centerX;                      //X轴中心
@property (nonatomic,readonly) HiLayoutMultiplierModel *centerY;                      //Y轴中心

/** item2 的 NSLayoutAttribute 和 item1 相同*/
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutItemModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutItemBlock item;

/** 除了 width height 之外, 都是 相对 super view */
@property (nonatomic,readonly) HiLayoutConstantBlock value;

@end

@interface HiLayoutRelatedModel : HiConstantModel

@property (nonatomic,readonly) HiLayoutRelatedBlock relate;

@property (nonatomic,readonly) HiLayoutItemModel *equal;
@property (nonatomic,readonly) HiLayoutItemModel *lessThanOrEqual;
@property (nonatomic,readonly) HiLayoutItemModel *greaterThanOrEqual;

@end

@interface UIView (HiConstraint)

@property (nonatomic,readonly) HiLayoutRelatedModel *hi_left_cs;                         //左侧
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_right_cs;                        //右侧
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_top_cs;                          //上方
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_bottom_cs;                       //下方
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_leading_cs;                      //首部
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_trailing_cs;                     //尾部
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_width_cs;                        //宽度
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_height_cs;                       //高度
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_centerX_cs;                      //X轴中心
@property (nonatomic,readonly) HiLayoutRelatedModel *hi_centerY_cs;                      //Y轴中心

- (void)hi_addConstraints:(HiConstraintBlock)block;

@end

NS_ASSUME_NONNULL_END
