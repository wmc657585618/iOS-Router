//
//  HiRouterFilter.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiRouterFilter.h"
#import "HiRouterPath.h"

@implementation HiRouterFilter

+ (HiFilterBody)hiFilterPath:(HiEnvironment *)env {
    
    return hiFilterMake(env.path, env.parameters);
}

- (HiFilterBody)hiFilterPath:(HiEnvironment *)env {
    
    return hiFilterMake(env.path, env.parameters);
}

+ (HiFilterBody)hiFilterTransition:(HiEnvironment *)env {
    /// 为了区分是否过滤 添加了 parameters
    if ([env.path isEqualToString:filter_normal] && env.parameters) {
        return hiFilterTransitioningMake(error, env.parameters, env.transition, env.modal);
    }
    return hiFilterTransitioningMake(env.path, env.parameters, env.transition, env.modal);
}

- (HiFilterBody)hiFilterTransition:(HiEnvironment *)env {
    /// 为了区分是否过滤 添加了 parameters
    if ([env.path isEqualToString:filter_normal] && env.parameters) {
        return hiFilterTransitioningMake(error, env.parameters, env.transition, env.modal);
    }
    return hiFilterTransitioningMake(env.path, env.parameters, env.transition, env.modal);
}

@end
