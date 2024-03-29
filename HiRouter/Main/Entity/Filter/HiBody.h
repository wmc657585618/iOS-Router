//
//  HiBody.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiFilterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiBody : NSObject

+ (instancetype)instanceWithPath:(NSString *)path parameters:(id)parameters modal:(UIModalPresentationStyle)modal transition:(HiRouterTransition)transition;
+ (instancetype)instanceWithPath:(NSString *)path parameters:(id)parameters;

/// 转场
@property (nonatomic, assign) HiRouterTransition transition;

@property (nonatomic, assign) UIModalPresentationStyle modal;
/// 路径
@property (nonatomic, copy) NSString *path;
/// 初始化参数
@property (nonatomic, strong) id parameters;

@end

NS_ASSUME_NONNULL_END
