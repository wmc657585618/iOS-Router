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

+ (void) bind:(NSObject<HiRouterViewModel> *)objcA objcB:(NSObject<HiRouterViewModel> *)objcB;

+ (void) objc:(NSObject<HiRouterViewModel> *)objc postData:(id)data;

@end
