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

typedef void(^HiRouterCallBack)(NSDictionary *callBack);

@interface HiRouter : NSObject

/**
 * instance
 */
@property (readonly, nonatomic, class) HiRouter *instance;

@property (readonly, nonatomic) NSDictionary<NSString *, NSString *> *routeDictionary;

- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary;

/**
 regist filer

 @param path filt path
 */
- (void)registFilter:(id<HiFilterProtocol>)filter forPath:(NSString *)path;

@end
