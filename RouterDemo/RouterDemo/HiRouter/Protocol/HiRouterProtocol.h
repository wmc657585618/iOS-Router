//
//  RouterProtocol.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterDefine.h"

@protocol HiInit <NSObject>

+ (instancetype)hi_init:(id)parameters;

@end

@protocol HiNetWork <HiInit>

@optional
// 得到 response (回调)
- (id)hi_response:(id)response;

// 得到 request (请求)
- (id)hi_request:(id)request;

@end

@protocol HiFilter <NSObject>

@optional
- (HiFilterBody)hiFilterPath:(NSString *)path init:(id)parameters request:(id)request;
+ (HiFilterBody)hiFilterPath:(NSString *)path init:(id)parameters request:(id)request;

- (HiFilterBody)hiFilterTransition:(HiRouterTransition)transition path:(NSString *)path init:(id)parameters request:(id)request;
+ (HiFilterBody)hiFilterTransition:(HiRouterTransition)transition path:(NSString *)path init:(id)parameters request:(id)request;

@end

