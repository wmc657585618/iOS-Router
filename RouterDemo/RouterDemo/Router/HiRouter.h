//
//  Router.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HiRouterBuilder.h"
#import "HiFilterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiRouter : NSObject

/**
 * instance
 */
@property (readonly, nonatomic, class) HiRouter *instance;

@property (readonly, nonatomic) NSDictionary<NSString *, NSString *> *routeDictionary;
@property (readonly, nonatomic) NSDictionary<NSString *, NSObject<HiFilterProtocol> *> *filters;

- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary;

/**
 regist filer
 */
- (void) registFilter:(NSObject<HiFilterProtocol> *)filter;

@end

NS_ASSUME_NONNULL_END
