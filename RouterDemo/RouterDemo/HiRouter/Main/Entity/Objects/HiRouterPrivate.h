//
//  HiRouterPrivate.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterProtocol.h"
#import "HiResponse.h"
#import "HiEnvironment.h"

@interface HiRouterProperty : NSObject

@property (nonatomic, weak) id<HiNetWork> delegate;
@property (nonatomic, copy) id (^block) (id parameters);

@end


@interface NSObject (HiRouterPrivate)

@property (nonatomic, strong, readonly) HiRouterProperty<HiFilter> *hi_router_property;

/// 过滤器链
@property (nonatomic, strong, readonly) NSMutableArray<HiFilter> *hi_filterChain;

/// 过滤器链
@property (nonatomic, strong, class, readonly) NSMutableArray *hi_filterChain;

@property (nonatomic, weak, readonly) id<HiNetWork> hi_router_delegate;
@property (nonatomic, copy, readonly) id (^hi_router_block) (id parameters);

/// 实例化
+ (instancetype)hi_objectForClass:(Class<HiInit>)cla withParameters:(id)parameters;

@end
