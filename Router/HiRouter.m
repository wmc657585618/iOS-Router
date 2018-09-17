//
//  Router.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouter.h"

@interface HiRouter ()<NSCopying,NSMutableCopying>

/**
 route dictionary
 */
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *pRouteDictionary;

@property (strong, nonatomic) NSMutableDictionary *parametersDictionary;

@property (strong, nonatomic) NSMutableDictionary<NSString *, HiRouterCallBack> *callBackDictionary;

@end

static HiRouter *_instance = nil;

@implementation HiRouter

/*********** instance router ***********/
+ (instancetype)instance {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _instance = (HiRouter *) [[super allocWithZone:NULL] init];
    });

    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    return HiRouter.instance;
}

- (id)copyWithZone:(NSZone *)zone {

    return HiRouter.instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {

    return HiRouter.instance;
}
/*********** instance router ***********/

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/****************** lazy ******************/
- (NSMutableDictionary *)parametersDictionary {
    
    if (!_parametersDictionary) {
        
        _parametersDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _parametersDictionary;
}

- (NSMutableDictionary<NSString *,HiRouterCallBack> *)callBackDictionary {
    
    if (!_callBackDictionary) {
        
        _callBackDictionary = [[NSMutableDictionary<NSString *,HiRouterCallBack> alloc] init];
    }
    
    return _callBackDictionary;
}
/****************** lazy ******************/

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

- (NSString *) keyWithObject:(UIViewController *)object {
    
    return NSStringFromClass(object.class);
}

- (id) objectWithPath:(NSString *)path {
    
    NSString *className = [self.pRouteDictionary objectForKey:path];
    
    NSAssert(className.length > 0, @"⚠️ no path match : %@!",path);
    
    Class class = NSClassFromString(className);
    
    NSAssert(class != nil, @"⚠️ has no class : %@!",className);
    
    id vc = [[class alloc] init];
    
    NSAssert([vc isKindOfClass:UIViewController.class], @"⚠️ class is not UIViewController!");
    
    return vc;
}

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

#pragma mark - public
/*********** regist router ***********/
- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary {
    
    self.pRouteDictionary = routeDictionary;
}

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/******************** page ********************/
- (HiRouterBuilder *) build:(NSString *)path {
    
    return [self build:path withParameters:nil];
}

- (HiRouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters {
    
    return [self build:path withParameters:parameters callBack:nil];
}

- (HiRouterBuilder *) build:(NSString *)path callBack:(HiRouterCallBack)callBack {

    return [self build:path withParameters:nil callBack:callBack];
}

- (HiRouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters callBack:(HiRouterCallBack)callBack {
    
    id object = [self objectWithPath:path];
    
    HiRouterBuilder *builder = [[HiRouterBuilder alloc] init];
    
    if (object && [object isKindOfClass:UIViewController.class]) {
        
        builder.viewController = (UIViewController *)object;
    }
    
    NSString *key = [self keyWithObject:object];
    
    NSAssert(key.length > 0,@"⚠️ key is nill");
    
    if (parameters) {
        
        [self.parametersDictionary setObject:parameters forKey:key];
    }
    
    if (callBack) {
        
        [self.callBackDictionary setObject:callBack forKey:key];
    }
    
    return builder;
}

/**
 get parameters
 */
- (NSDictionary *) parametersForViewController:(UIViewController *)viewController {
    
    NSString *key = [self keyWithObject:viewController];
    
    NSDictionary *dic = [self.parametersDictionary objectForKey:key];
    
    [self.parametersDictionary removeObjectForKey:key];
    
    return dic;
}

/**
 get callback
 */
- (HiRouterCallBack) callBackForViewController:(UIViewController *)viewController {
    
    NSString *key = [self keyWithObject:viewController];

    HiRouterCallBack callBack = [self.callBackDictionary objectForKey:key];
    
    [self.callBackDictionary removeObjectForKey:key];
    
    return callBack;
}
/******************** page ********************/

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/************* view model *************/
/**
 build view and model in dynamic
 */

- (void) buildViewModelInDynamic:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB {


    [HiRouterVMBuilder bind:objectA objcB:objectB];
}

/************* view model *************/

@end
