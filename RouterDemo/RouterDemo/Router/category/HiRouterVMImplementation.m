//
//  HiRouterVMImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"

@implementation HiRouter (VM)

/**
 build view and model in dynamic
 */

- (void) buildViewModelInDynamic:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB {
    
    [HiRouterVMBuilder bind:objectA objcB:objectB];
}

- (void) invork:(id<HiRouterViewModel>)invork postData:(id)data {
    
    [HiRouterVMBuilder objc:invork postData:data];
}

@end
