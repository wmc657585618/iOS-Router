//
//  HiAnnotation.h
//  RouterDemo
//
//  Created by four on 2021/4/2.
//  Copyright © 2021 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterManager.h"

NS_ASSUME_NONNULL_BEGIN

#define Router(_url_,_class_) class _class_;\
__attribute__((constructor)) static inline void hi_##_class_()\
{@#_url_.hi_class = NSClassFromString(@#_class_);}\
__attribute__((objc_runtime_name(#_class_)))

NS_ASSUME_NONNULL_END
