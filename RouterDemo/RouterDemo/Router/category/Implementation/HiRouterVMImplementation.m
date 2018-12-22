//
//  HiRouterVMImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"
#import "HiRouterVMBuilder.h"

@implementation HiRouter (VM)

/**
 build view and model in dynamic
 */

- (void) buildViewModelInDynamic:(NSObject<HiRouterViewModel> *)objectA objectB:(NSObject<HiRouterViewModel> *)objectB {
    
    [HiRouterVMBuilder bind:objectA objcB:objectB];
}

- (void) invork:(NSObject<HiRouterViewModel> *)invork postData:(id)data {
    
    [HiRouterVMBuilder objc:invork postData:data];
}

@end
