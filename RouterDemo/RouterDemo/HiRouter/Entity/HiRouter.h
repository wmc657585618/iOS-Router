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

+ (instancetype)objectForPath:(NSString *)path;

+ (instancetype)objectForPath:(NSString *)path withInitParameters:(id)parameters;

+ (instancetype)objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;

/// instance 并添加回调 self.
- (id)objectForPath:(NSString *)path;

- (id)objectForPath:(NSString *)path withInitParameters:(id)parameters;

- (id)objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;

@property (nonatomic, weak) id<HiNetWork> hi_router_delegate;


/// 回调
- (void)makeResponse:(id)response;

/// 绑定回调对象
- (void)bindObject:(id)object;

+ (void)registFilter:(id<HiFilter>)filter;

@end


@interface UIViewController (HiRouter)

- (id)pushPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated;

- (id)presentPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated completion:(void (^)(void))completion;

- (id)transition:(HiRouterTransition)transition path:(NSString *)path initParameters:(id)parameters request:(id)request modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void (^)(void))completion;

@end

