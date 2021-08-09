//
//  HiBody.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiBody.h"

@implementation HiBody

+ (instancetype)instanceWithPath:(NSString *)path parameters:(id)parameters modal:(UIModalPresentationStyle)modal transition:(HiRouterTransition)transition {
    HiBody *env = [[self alloc] init];
    env.path = path;
    env.parameters = parameters;
    env.modal = modal;
    env.transition = transition;
    return env;
}

+ (instancetype)instanceWithPath:(NSString *)path parameters:(id)parameters {
    return [self instanceWithPath:path parameters:parameters modal:UIModalPresentationFullScreen transition:HiRouterTransitionNone];
}

@end
