//
//  UIViewHiFrameExtension.h
//  RouterDemo
//
//  Created by four on 2020/5/18.
//  Copyright © 2020 Four. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HiFrameItemAttributeModel,
HiFrameMultiplierModel,
HiFramConstantModel;

typedef HiFrameItemAttributeModel * _Nullable (^HiFrameRelatedBlock)(UIView *view);
typedef HiFrameMultiplierModel * _Nullable (^HiFrameItemAttributeBlock)(NSLayoutAttribute attribute);
typedef HiFramConstantModel * _Nullable (^HiFrameMultiplierBlock)(CGFloat multiplier);
typedef CGFloat (^HiFramConstantBlock)(CGFloat constant);

typedef void(^HiLayoutFrameBlock)(UIView *hivlf);

#pragma mark - property
@interface HiLayoutFrameModel : NSObject

@end

@interface HiFramConstantModel : HiLayoutFrameModel

@property (nonatomic,copy,readonly) HiFramConstantBlock constant;

@end

@interface HiFrameMultiplierModel : HiLayoutFrameModel

@property (nonatomic,copy,readonly) HiFrameMultiplierBlock multiplier;

@end

@interface HiFrameItemAttributeModel : HiLayoutFrameModel

@property (nonatomic,readonly) HiFrameItemAttributeBlock attribute;

@property (nonatomic,readonly) HiFrameMultiplierModel *left;                         //左侧
@property (nonatomic,readonly) HiFrameMultiplierModel *right;                        //右侧
@property (nonatomic,readonly) HiFrameMultiplierModel *top;                          //上方
@property (nonatomic,readonly) HiFrameMultiplierModel *bottom;                       //下方
@property (nonatomic,readonly) HiFrameMultiplierModel *leading;                      //首部
@property (nonatomic,readonly) HiFrameMultiplierModel *trailing;                     //尾部
@property (nonatomic,readonly) HiFrameMultiplierModel *width;                        //宽度
@property (nonatomic,readonly) HiFrameMultiplierModel *height;                       //高度
@property (nonatomic,readonly) HiFrameMultiplierModel *centerX;                      //X轴中心
@property (nonatomic,readonly) HiFrameMultiplierModel *centerY;                      //Y轴中心

/** item2 的 NSLayoutAttribute 和 item1 相同*/
@property (nonatomic,readonly) HiFramConstantBlock value;

@end

@interface HiFrameRelatedModel : HiLayoutFrameModel

@property (nonatomic,readonly) HiFrameRelatedBlock equal;

/** 除了 width height 之外, 都是 相对 super view */
@property (nonatomic,readonly) HiFramConstantBlock value;

@end

#pragma mark - ************* property *************

@interface UIView (HiFrame)

@property (nonatomic,readonly) HiFrameRelatedModel *hi_left;                         //左侧
@property (nonatomic,readonly) HiFrameRelatedModel *hi_right;                        //右侧
@property (nonatomic,readonly) HiFrameRelatedModel *hi_top;                          //上方
@property (nonatomic,readonly) HiFrameRelatedModel *hi_bottom;                       //下方
@property (nonatomic,readonly) HiFrameRelatedModel *hi_leading;                      //首部
@property (nonatomic,readonly) HiFrameRelatedModel *hi_trailing;                     //尾部
@property (nonatomic,readonly) HiFrameRelatedModel *hi_width;                        //宽度
@property (nonatomic,readonly) HiFrameRelatedModel *hi_height;                       //高度
@property (nonatomic,readonly) HiFrameRelatedModel *hi_centerX;                      //X轴中心
@property (nonatomic,readonly) HiFrameRelatedModel *hi_centerY;                      //Y轴中心

- (void)hi_addFrameConstraints:(HiLayoutFrameBlock)block;

@end

NS_ASSUME_NONNULL_END
