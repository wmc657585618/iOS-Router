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

#define implementation_router(_url_,_class_) interface _class_##HiAnnotation : NSObject @end\
@implementation _class_##HiAnnotation\
+ (void)load {@#_url_.hi_class = NSClassFromString(@#_class_);}\
@end\
@implementation _class_;

@interface HiAnnotation : NSObject

@end

NS_ASSUME_NONNULL_END
