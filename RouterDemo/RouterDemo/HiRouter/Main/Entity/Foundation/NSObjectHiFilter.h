//
//  NSObjectHiFilter.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HiFilter)

/// 过滤器 遵守 HiFilter 协议
- (void)becomeFilter;
+ (void)becomeFilter;

@end
