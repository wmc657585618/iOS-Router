//
//  RouterVMBuilder.m
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterVMBuilder.h"

@implementation HiRouterVMBuilder

+ (void) bind:(id<HiRouterViewModel>)objcA objcB:(id<HiRouterViewModel>)objcB {

    [self pBind:objcA objcB:objcB];
    [self pBind:objcB objcB:objcA];

}

+ (void) pBind:(id<HiRouterViewModel>)objcA objcB:(id<HiRouterViewModel>)objcB {

    __weak typeof(objcB) weakB = objcB;

    [objcA invorkerCommond:^(NSDictionary *commond) {

        __strong typeof(weakB) strongB = weakB;

        if ([strongB respondsToSelector:@selector(received:)]) {

            [strongB received:commond];
        }
    }];
}
@end
