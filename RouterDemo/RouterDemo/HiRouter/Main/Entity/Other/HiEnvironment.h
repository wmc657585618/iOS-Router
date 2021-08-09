//
//  HiEnvironment.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiBody.h"

NS_ASSUME_NONNULL_BEGIN
/// 路由环境参数
@interface HiEnvironment : HiBody

/// filter 中是否结束循环
@property (nonatomic, assign, readonly) BOOL isBreak;

/// 结束循环
- (void)breakChain;
@end

NS_ASSUME_NONNULL_END
