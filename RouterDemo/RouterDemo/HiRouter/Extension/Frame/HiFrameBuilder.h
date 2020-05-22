//
//  HiFrameBuilder.h
//  RouterDemo
//
//  Created by four on 2020/5/21.
//  Copyright © 2020 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HiFrameModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiFrameBuilder : NSObject

@property (nonatomic,readonly) HiFrameRelatedModel *hi_left;                         //左侧
@property (nonatomic,readonly) HiFrameRelatedModel *hi_right;                        //右侧
@property (nonatomic,readonly) HiFrameRelatedModel *hi_top;                          //上方
@property (nonatomic,readonly) HiFrameRelatedModel *hi_bottom;                       //下方
@property (nonatomic,readonly) HiFrameRelatedModel *hi_width;                        //宽度
@property (nonatomic,readonly) HiFrameRelatedModel *hi_height;                       //高度
@property (nonatomic,readonly) HiFrameRelatedModel *hi_centerX;                      //X轴中心
@property (nonatomic,readonly) HiFrameRelatedModel *hi_centerY;                      //Y轴中心

- (instancetype)initWithView:(UIView *)view;

- (void)updateFrame;

@end

NS_ASSUME_NONNULL_END
