//
//  Router.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "Router.h"

@interface Router ()<NSCopying,NSMutableCopying>

/**
 route dictionary
 */
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *_routeDictionary;

@property (copy, nonatomic) NSDictionary<NSString *, NSDictionary *> *_viewModelRouteDictionary;

@property (strong, nonatomic) NSMutableDictionary *parametersDictionary;

@property (strong, nonatomic) NSMutableDictionary<NSString *, RouterCallBack> *callBackDictionary;

@end

static Router *_instance = nil;

@implementation Router

/*********** instance router ***********/
+ (instancetype)instance {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _instance = [[super allocWithZone:NULL] init] ;
    });

    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    return Router.instance;
}

- (id)copyWithZone:(NSZone *)zone {

    return Router.instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {

    return Router.instance;
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

- (NSMutableDictionary<NSString *,RouterCallBack> *)callBackDictionary {
    
    if (!_callBackDictionary) {
        
        _callBackDictionary = [[NSMutableDictionary<NSString *,RouterCallBack> alloc] init];
    }
    
    return _callBackDictionary;
}
/****************** lazy ******************/

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

- (NSString *) keyWithObject:(UIViewController *)object {
    
    return NSStringFromClass(object.class);
}

- (id) objectWithPath:(NSString *)path {
    
    NSString *className = [self._routeDictionary objectForKey:path];
    
    NSAssert(className.length > 0, @"⚠️ no path match : %@!",path);
    
    Class class = NSClassFromString(className);
    
    NSAssert(class != nil, @"⚠️ has no class : %@!",className);
    
    id vc = [class alloc];
    
    NSAssert([vc isKindOfClass:UIViewController.class], @"⚠️ class is not UIViewController!");
    
    return vc;
}

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

#pragma mark - public
/*********** regist router ***********/
- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary {
    
    self._routeDictionary = routeDictionary;
}

- (void) registViewModelRoute:(NSDictionary<NSString *, NSDictionary *> *)viewModelRouteDictionary {
    
    self._viewModelRouteDictionary = viewModelRouteDictionary;
}

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/******************** page ********************/
- (RouterBuilder *) build:(NSString *)path {
    
    return [self build:path withParameters:nil];
}

- (RouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters {
    
    return [self build:path withParameters:parameters callBack:nil];
}

- (RouterBuilder *) build:(NSString *)path callBack:(RouterCallBack)callBack {

    return [self build:path withParameters:nil callBack:callBack];
}

- (RouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters callBack:(RouterCallBack)callBack {
    
    id object = [self objectWithPath:path];
    
    RouterBuilder *builder = [[RouterBuilder alloc] init];
    
    if (object && [object isKindOfClass:UIViewController.class]) {
        
        builder.viewController = (UIViewController *)object;
    }
    
    NSString *key = [self keyWithObject:object];
    
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
- (RouterCallBack) callBackForViewController:(UIViewController *)viewController {
    
    NSString *key = [self keyWithObject:viewController];

    RouterCallBack callBack = [self.callBackDictionary objectForKey:key];
    
    [self.callBackDictionary removeObjectForKey:key];
    
    return callBack;
}
/******************** page ********************/

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */

/************* view model *************/

/**
 build for path
 */
- (RouterVMBuilder *) buildViewModel:(NSString *)path {
    
    NSDictionary *dictionary = [self._viewModelRouteDictionary objectForKey:path];
    
    NSString *receiver = [dictionary objectForKey:@"receiver"];
    
    NSString *invorker = [dictionary objectForKey:@"invorker"];
    
    Class receiverClass = NSClassFromString(receiver);
    
    Class invorkerClass = NSClassFromString(invorker);
    
    return [self buildViewModelInDynamic:[receiverClass new] objectB:[invorkerClass new]];
}

/**
 build view and model in dynamic
 */
- (RouterVMBuilder *) buildViewModelInDynamic:(id<RouterViewModel>)objectA objectB:(id<RouterViewModel>)objectB {
    
    RouterVMBuilder *builder = [[RouterVMBuilder alloc] init];

    [self updateVMBuilder:builder objectA:objectA objectB:objectB];
    
    return builder;
}

/**
 update view and model of builder
 */
- (void) updateVMBuilder:(RouterVMBuilder *)builder objectA:(id<RouterViewModel>)objectA objectB:(id<RouterViewModel>)objectB {
    
    builder.receiver = objectA;
    
    builder.invorker = objectB;
    
    [builder bind];
}

/**
 build view model group with reuseIdentifier
 */
- (RouterVMBuilder *) buildViewModeGrouplInDynamic:(id<RouterViewModel>)objectA objectB:(id<RouterViewModel>)objectB reuseIdentifier:(NSString *)reuseIdentifier group:(RouterVMBuilderGroup *)group {
    
    RouterVMBuilder *builder = [self buildViewModelInDynamic:objectA objectB:objectB];
    
    [group setVMBuilder:builder forKey:reuseIdentifier];
    
    return builder;
}
/************* view model *************/

@end
