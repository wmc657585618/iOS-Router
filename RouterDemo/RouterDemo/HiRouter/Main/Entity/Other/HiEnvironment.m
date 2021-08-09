//
//  HiEnvironment.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiEnvironment.h"

@implementation HiEnvironment

+ (instancetype)environmentWithPath:(NSString *)path parameters:(id)parameters modal:(UIModalPresentationStyle)modal transition:(HiRouterTransition)transition {
    HiEnvironment *env = [[self alloc] init];
    env.path = path;
    env.parameters = parameters;
    env.modal = modal;
    env.transition = transition;
    return env;
}

+ (instancetype)environmentWithPath:(NSString *)path parameters:(id)parameters {
    return [self environmentWithPath:path parameters:parameters modal:UIModalPresentationFullScreen transition:HiRouterTransitionNone];
}

@end
