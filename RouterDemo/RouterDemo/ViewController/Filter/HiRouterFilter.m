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

+ (void)hiFilterPath:(HiEnvironment *)env response:(HiResponse *)response{
    
}

- (void)hiFilterPath:(HiEnvironment *)env response:(HiResponse *)response{
    
}

+ (void)hiFilterTransition:(HiEnvironment *)env response:(HiResponse *)response{
    [env breakChain];
    /// 为了区分是否过滤 添加了 parameters
    if ([env.path isEqualToString:filter_normal] && env.parameters) {
        response.path = error;
    }
}

- (void)hiFilterTransition:(HiEnvironment *)env response:(HiResponse *)response{
    [HiRouterFilter hiFilterTransition:env response:response];
}

@end
