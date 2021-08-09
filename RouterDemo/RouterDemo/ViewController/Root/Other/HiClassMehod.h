//
//  HiClassMehod.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterManager.h"

NS_ASSUME_NONNULL_BEGIN
@Router(class/method, HiClassMehod)
@interface HiClassMehod : NSObject<HiClass>

@end

@Router(class/init, HiObjectInit)
@interface HiObjectInit : NSObject<HiInit>

@end

NS_ASSUME_NONNULL_END
