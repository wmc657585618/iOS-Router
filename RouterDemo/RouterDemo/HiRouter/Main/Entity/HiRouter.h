//
//  Router.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiRouterProtocol.h"

@interface NSString (HiPathClass)

@property (nonatomic,strong) Class hi_class;

/// 调用 类方法
/// @param request 参数
/// @param response 回调
- (Class)hi_request:(id)request response:(id(^)(id response))response;

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

/// 过滤器 遵守 HiFilter 协议的
/// 只能有一个过滤器,多个 只有第一个 遵守 HiFilter 协议的 有效
- (void)becomeFilter;
+ (void)becomeFilter;

@end


@interface UIViewController (HiRouter)

/// self 是 UINavigationController 或者 UIViewController
/// UINavigationController 直接 push
/// UIViewController 调用 self.navigationController push
- (id)hi_pushPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated;

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters animated:(BOOL)animated completion:(void (^)(void))completion;

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion;

@end

