//
//  NSObjectHiRouter.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiRouterProtocol.h"

@interface NSString (HiPathClass)

@property (nonatomic,strong) Class hi_class;

/// 调用 类方法
/// @param request 参数
/// @return response
- (id)hi_request:(id)request;

@end

@interface NSObject (HiRouter)

+ (instancetype)hi_instanceForPath:(NSString *)path;

+ (instancetype)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters;

/// 创建 path 相对的 实例对象
- (id)hi_objectForPath:(NSString *)path;

/// 创建 path 相对的 实例对象
- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters;

/// 添加回调
- (void)setHi_router_delegate:(id<HiNetWork>)hi_router_delegate;
- (void)setHi_router_block:(id (^)(id response))hi_router_block;

/// 回调
/// 优先 block
- (id)hi_makeResponse:(id)response;

@end
