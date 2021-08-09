//
//  HiRouterPrivate.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterProtocol.h"


@interface HiRouterProperty : NSObject

@property (nonatomic, weak) id<HiNetWork> delegate;
@property (nonatomic, copy) id (^block) (id parameters);

@end


@interface NSObject (HiRouterPrivate)

@property (nonatomic, strong, readonly) HiRouterProperty *hi_router_property;

@property (nonatomic, strong) id hi_filter;
@property (nonatomic, strong, class) id hi_filter;

@property (nonatomic, weak, readonly) id<HiNetWork> hi_router_delegate;
@property (nonatomic, copy, readonly) id (^hi_router_block) (id parameters);

/// 实例化
+ (instancetype)hi_objectForClass:(Class<HiInit>)cla withParameters:(id)parameters;

@end
