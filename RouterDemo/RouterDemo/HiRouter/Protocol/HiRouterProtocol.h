//
//  RouterProtocol.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiEnvironment.h"

@protocol HiInit <NSObject>

+ (instancetype)hi_init:(id)parameters;

@end

@protocol HiNetWork <NSObject>

@optional
/// 得到 response (回调)
- (id)hi_response:(id)response;

/// 得到 request (请求)
- (id)hi_request:(id)request;

@end

@protocol HiClass <NSObject>

/// 类 实现调用
/// @param request 请求
+ (id)hi_request:(id)request;

@end

@protocol HiFilter <NSObject>

@optional
/// 创建
- (HiFilterBody)hiFilterPath:(HiEnvironment *)env;
+ (HiFilterBody)hiFilterPath:(HiEnvironment *)env;

/// 转场
- (HiFilterBody)hiFilterTransition:(HiEnvironment *)env;
+ (HiFilterBody)hiFilterTransition:(HiEnvironment *)env;

@end

