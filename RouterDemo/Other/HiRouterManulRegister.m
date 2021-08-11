//
//  HiRouterManulRegister.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiRouterManulRegister.h"
#import "HiRouterPath.h"

#import "HiParametersViewController.h"
#import "HiCallBackViewController.h"
#import "HiFilterViewController.h"
#import "HiErrorViewController.h"
#import "HiFilterNormalViewController.h"

@implementation HiRouterManulRegister

+ (void)regist {
    parameters.hi_class = [HiParametersViewController class];
    callback.hi_class = [HiCallBackViewController class];
    filter_normal.hi_class = [HiFilterNormalViewController class];
    filter.hi_class = [HiFilterViewController class];
    error.hi_class = [HiErrorViewController class];
}

@end
