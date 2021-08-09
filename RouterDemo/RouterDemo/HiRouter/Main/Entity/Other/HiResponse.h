//
//  HiResponse.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiRouterDefine.h"

@interface HiResponse : NSObject

@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) HiRouterTransition transition;
@property (nonatomic, assign) UIModalPresentationStyle modal;
@property (nonatomic, strong) id parameters; // init 参数

+ (instancetype)responseWithPath:(NSString *)path parameters:(id)parameters modal:(UIModalPresentationStyle)modal transition:(HiRouterTransition)transition;
+ (instancetype)responseWithPath:(NSString *)path parameters:(id)parameters;

@end
