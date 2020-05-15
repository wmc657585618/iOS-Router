//
//  UIViewHiExtension.h
//  RouterDemo
//
//  Created by four on 2020/5/14.
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

#pragma mark - layout
@interface HiLayoutModel : NSObject

@property (nonatomic,copy,readonly) HiLayoutBlock multiplier;
@property (nonatomic,copy,readonly) HiLayoutBlock constant;

@end

#pragma mark - constant
@interface HiConstantModel : NSObject

@end

@interface HiLayoutConstantModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutConstantBlock constant;

@end

@interface HiLayoutMultiplierModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutMultiplierBlock multiplier;

@end

@interface HiLayoutItemAttributeModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutItemAttributeBlock attribute;

@end

@interface HiLayoutItemModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutItemBlock item;

@end

@interface HiLayoutRelatedModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutRelatedBlock relate;

@property (nonatomic,strong,readonly) HiLayoutItemModel *equal;
@property (nonatomic,strong,readonly) HiLayoutItemModel *lessThanOrEqual;
@property (nonatomic,strong,readonly) HiLayoutItemModel *greaterThanOrEqual;

@end

@interface HiLayoutAttributeModel : HiConstantModel

@property (nonatomic,copy,readonly) HiLayoutAttributeBlock attribute;

@end

#pragma mark - view

@interface UIView (HiCategory)

@property (nonatomic,strong,readonly) HiLayoutModel *hi_left;                         //左侧
@property (nonatomic,strong,readonly) HiLayoutModel *hi_right;                        //右侧
@property (nonatomic,strong,readonly) HiLayoutModel *hi_top;                          //上方
@property (nonatomic,strong,readonly) HiLayoutModel *hi_bottom;                       //下方
@property (nonatomic,strong,readonly) HiLayoutModel *hi_leading;                      //首部
@property (nonatomic,strong,readonly) HiLayoutModel *hi_trailing;                     //尾部
@property (nonatomic,strong,readonly) HiLayoutModel *hi_width;                        //宽度
@property (nonatomic,strong,readonly) HiLayoutModel *hi_height;                       //高度
@property (nonatomic,strong,readonly) HiLayoutModel *hi_centerX;                      //X轴中心
@property (nonatomic,strong,readonly) HiLayoutModel *hi_centerY;                      //Y轴中心
@end

@interface UIView (HiConstraint)

@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_left_cs;                         //左侧
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_right_cs;                        //右侧
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_top_cs;                          //上方
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_bottom_cs;                       //下方
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_leading_cs;                      //首部
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_trailing_cs;                     //尾部
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_width_cs;                        //宽度
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_height_cs;                       //高度
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_centerX_cs;                      //X轴中心
@property (nonatomic,strong,readonly) HiLayoutRelatedModel *hi_centerY_cs;                      //Y轴中心

@end

NS_ASSUME_NONNULL_END
