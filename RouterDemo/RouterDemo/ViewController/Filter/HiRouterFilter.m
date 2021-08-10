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

+ (void)hiFilterPath:(HiFilterEnvironment)env response:(HiFilterResponse)response{
    
}

- (void)hiFilterPath:(HiFilterEnvironment)env response:(HiFilterResponse)response{
    
}

+ (void)hiFilterTransition:(HiFilterEnvironment)env response:(HiFilterResponse)response{
    [env breakChain];
    /// 为了区分是否过滤 添加了 parameters
    if ([env.path isEqualToString:filter_normal] && env.parameters) {
        response.path = error;
    }
}

- (void)hiFilterTransition:(HiFilterEnvironment)env response:(HiFilterResponse)response{
    [HiRouterFilter hiFilterTransition:env response:response];
}

@end
