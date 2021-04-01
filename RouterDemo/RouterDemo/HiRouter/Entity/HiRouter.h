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

@end

@interface NSObject (HiRouter)

+ (instancetype)hi_instanceForPath:(NSString *)path;

+ (instancetype)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters;

+ (instancetype)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;

/// instance 并添加回调给 self.
- (id)hi_objectForPath:(NSString *)path;

- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters;

- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;

@property (nonatomic, weak) id<HiNetWork> hi_router_delegate;


/// 回调
- (void)makeResponse:(id)response;

/// 绑定回调对象
- (void)bindObject:(id)object;

+ (void)registFilter:(id<HiFilter>)filter;

@end


@interface UIViewController (HiRouter)

- (id)hi_pushPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated;

- (id)hi_presentPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated completion:(void (^)(void))completion;

- (id)hi_transition:(HiRouterTransition)transition path:(NSString *)path initParameters:(id)parameters request:(id)request modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion;

@end

