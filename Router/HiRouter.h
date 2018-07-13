//
//  Router.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HiRouterBuilder.h"

#import "HiRouterVMBuilderGroup.h"

typedef void(^HiRouterCallBack)(NSDictionary *callBack);

@interface HiRouter : NSObject

/**
 * instance
 */
@property (readonly, nonatomic, class) HiRouter *instance;

- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary;

- (void) registViewModelRoute:(NSDictionary<NSString *, NSDictionary *> *)viewModelRouteDictionary;

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/******************** page ********************/
/**
 no parameters no callback
 */
- (HiRouterBuilder *) build:(NSString *)path;

/**
 with parameters
 */
- (HiRouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters;

/**
 with callback
 */
- (HiRouterBuilder *) build:(NSString *)path callBack:(HiRouterCallBack)callBack;

/**
 with parameters and callback
 */
- (HiRouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters callBack:(HiRouterCallBack)callBack;

/**
 get parameters
 */
- (NSDictionary *) parametersForViewController:(UIViewController *)viewController;

/**
 get callback
 */
- (HiRouterCallBack) callBackForViewController:(UIViewController *)viewController;
/******************** page ********************/

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/******************** view model ********************/

/**
 build for path
 */
- (HiRouterVMBuilder *) buildViewModel:(NSString *)path;

/**
 build view and model in dynamic
 */
- (HiRouterVMBuilder *) buildViewModelInDynamic:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB;

/**
 update view and model of builder
 */
- (void) updateVMBuilder:(HiRouterVMBuilder *)builder objectA:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB;

/**
 build view model group with reuseIdentifier
 */
- (HiRouterVMBuilder *) buildViewModeGrouplInDynamic:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB reuseIdentifier:(NSString *)reuseIdentifier group:(HiRouterVMBuilderGroup *)group;
/******************** view model ********************/


@end
