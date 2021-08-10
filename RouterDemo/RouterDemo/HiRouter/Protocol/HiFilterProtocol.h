//
//  HiFilterProtocol.h
//  RouterDemo
//
//  Created by four on 2021/8/10.
//  Copyright © 2021 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiDefine.h"

@protocol HiFilterURN <NSObject>

@property (nullable, copy, readonly) NSString *scheme;
@property (nullable, copy, readonly) NSString *path;

@end

@protocol HiFilterEnvironment <NSObject>

/// 路径
@property (nonatomic, strong, readonly) id<HiFilterURN> _Nonnull urn;

/// 转场
@property (nonatomic, assign, readonly) HiRouterTransition transition;

@property (nonatomic, assign, readonly) UIModalPresentationStyle modal;

/// 初始化参数
@property (nonatomic, strong, readonly) id _Nullable parameters;

/// filter 中是否结束循环
@property (nonatomic, assign, readonly) BOOL isBreak;

/// 结束循环
- (void)breakChain;


@end

@protocol HiFilterResponse <NSObject>

/// 转场
@property (nonatomic, assign) HiRouterTransition transition;

@property (nonatomic, assign) UIModalPresentationStyle modal;
/// 路径
@property (nonatomic, copy) NSString * _Nullable path;
/// 初始化参数
@property (nonatomic, strong) id _Nullable parameters;

@end

typedef id<HiFilterResponse> HiFilterResponse;
typedef id<HiFilterEnvironment> HiFilterEnvironment;
