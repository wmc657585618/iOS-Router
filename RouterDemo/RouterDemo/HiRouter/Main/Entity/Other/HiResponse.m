//
//  HiResponse.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiResponse.h"

@implementation HiResponse

+ (instancetype)responseWithPath:(NSString *)path parameters:(id)parameters modal:(UIModalPresentationStyle)modal transition:(HiRouterTransition)transition {
    HiResponse *env = [[self alloc] init];
    env.path = path;
    env.parameters = parameters;
    env.modal = modal;
    env.transition = transition;
    return env;
}

+ (instancetype)responseWithPath:(NSString *)path parameters:(id)parameters {
    return [self responseWithPath:path parameters:parameters modal:UIModalPresentationFullScreen transition:HiRouterTransitionNone];
}


@end
