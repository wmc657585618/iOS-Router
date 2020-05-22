//
//  HiFrameModel.h
//  ZYBScanSearch
//
//  Created by four on 2020/5/20.
//  Copyright © 2020 zuoyebang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiFrameOptionManager.h"

NS_ASSUME_NONNULL_BEGIN

@class HiFrameItemAttributeModel,
HiFrameMultiplierModel,
HiFramConstantModel;

typedef HiFrameItemAttributeModel * _Nullable (^HiFrameRelatedBlock)(UIView *view);
typedef HiFrameMultiplierModel * _Nullable (^HiFrameItemAttributeBlock)(NSLayoutAttribute attribute);
typedef HiFramConstantModel * _Nullable (^HiFrameMultiplierBlock)(CGFloat multiplier);
typedef CGFloat (^HiFramConstantBlock)(CGFloat constant); // 对应的值 比如 x y bottom ...


#pragma mark - property
@interface HiLayoutFrameModel : NSObject

@end

@interface HiFramConstantModel : HiLayoutFrameModel

@property (nonatomic,copy,readonly) HiFramConstantBlock value;

@end

@interface HiFrameMultiplierModel : HiLayoutFrameModel

@property (nonatomic,copy,readonly) HiFrameMultiplierBlock multiplier;

@property (nonatomic,readonly) HiFramConstantBlock value;

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

- (instancetype)initWithOption:(HiFrameOptionManager *)option attribute:(NSLayoutAttribute)attribute;

@end

NS_ASSUME_NONNULL_END
