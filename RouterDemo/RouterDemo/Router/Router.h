//
//  Router.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RouterBuilder.h"

#import "RouterVMBuilderGroup.h"

typedef void(^RouterCallBack)(NSDictionary *callBack);

@interface Router : NSObject

/**
 * instance
 */
@property (readonly, nonatomic, class) Router *instance;

- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary;

- (void) registViewModelRoute:(NSDictionary<NSString *, NSDictionary *> *)viewModelRouteDictionary;

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/******************** page ********************/
/**
 no parameters no callback
 */
- (RouterBuilder *) build:(NSString *)path;

/**
 with parameters
 */
- (RouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters;

/**
 with callback
 */
- (RouterBuilder *) build:(NSString *)path callBack:(RouterCallBack)callBack;

/**
 with parameters and callback
 */
- (RouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters callBack:(RouterCallBack)callBack;

/**
 get parameters
 */
- (NSDictionary *) parametersForViewController:(UIViewController *)viewController;

/**
 get callback
 */
- (RouterCallBack) callBackForViewController:(UIViewController *)viewController;
/******************** page ********************/

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/******************** view model ********************/

/**
 build for path
 */
- (RouterVMBuilder *) buildViewModel:(NSString *)path;

/**
 build view and model in dynamic
 */
- (RouterVMBuilder *) buildViewModelInDynamic:(id<RouterViewModel>)objectA objectB:(id<RouterViewModel>)objectB;

/**
 update view and model of builder
 */
- (void) updateVMBuilder:(RouterVMBuilder *)builder objectA:(id<RouterViewModel>)objectA objectB:(id<RouterViewModel>)objectB;

/**
 build view model group with reuseIdentifier
 */
- (RouterVMBuilder *) buildViewModeGrouplInDynamic:(id<RouterViewModel>)objectA objectB:(id<RouterViewModel>)objectB reuseIdentifier:(NSString *)reuseIdentifier group:(RouterVMBuilderGroup *)group;
/******************** view model ********************/


@end
