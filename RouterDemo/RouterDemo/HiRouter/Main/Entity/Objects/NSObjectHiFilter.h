//
//  NSObjectHiFilter.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HiFilter)

/// 过滤器 遵守 HiFilter 协议的
/// 只能有一个过滤器,多个 只有第一个 遵守 HiFilter 协议的 有效
- (void)becomeFilter;
+ (void)becomeFilter;

@end
