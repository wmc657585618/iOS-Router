//
//  HiRouter+VM.h
//  RouterDemo
//
//  Created by four on 2018/11/12.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouter.h"
#import "HiRouterVMBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiRouter (VM)

/******************** view model ********************/

/**
 build view and model in dynamic
 */
- (void) buildViewModelInDynamic:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB;

- (void) invork:(id<HiRouterViewModel>)invork postData:(id)data;

/******************** view model ********************/

@end

NS_ASSUME_NONNULL_END
