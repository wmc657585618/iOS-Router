//
//  Router.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterProtocol.h"
#import <UIKit/UIKit.h>

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

+ (instancetype)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;

/// instance 并添加回调给 self.
- (id)hi_objectForPath:(NSString *)path;

- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters;

- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;

/// 添加回调
- (void)setHi_router_delegate:(id<HiNetWork>)hi_router_delegate;
- (void)setHi_router_block:(id (^)(id))hi_router_block;

/// 回调
/// 优先 block
- (void)hi_makeResponse:(id)response;

+ (void)hi_registFilter:(id<HiFilter>)filter;

@end


@interface UIViewController (HiRouter)

- (id)hi_pushPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated;

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated completion:(void (^)(void))completion;

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters request:(id)request modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion;

@end
