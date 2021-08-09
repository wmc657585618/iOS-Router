//
//  HiClassMehod.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiClassMehod.h"

@implementation HiClassMehod

+ (id)hi_request:(id)request {
    return [[NSString alloc] initWithFormat:@"调用了 %@ 类的 request 方法. 参数:%@",NSStringFromClass(self),request];
}

@end

@implementation HiObjectInit


+ (instancetype)hi_init:(id)parameters {
    return [[self alloc] init];
}

@end
