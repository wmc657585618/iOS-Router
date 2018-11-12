//
//  RouterVMBuilder.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterProtocol.h"

@interface HiRouterVMBuilder : NSObject

+ (void) bind:(id<HiRouterViewModel>)objcA objcB:(id<HiRouterViewModel>)objcB;

+ (void) objc:(id<HiRouterViewModel>)objc postData:(id)data;

@end

@interface NSObject (delegate)<HiRouterViewModel>

@end
