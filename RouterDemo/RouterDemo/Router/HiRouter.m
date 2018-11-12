//
//  Router.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouter.h"
#import "HiRouterVMBuilder.h"

@interface HiRouter ()<NSCopying,NSMutableCopying>

/**
 route dictionary
 */
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *pRouteDictionary;

@property (strong, nonatomic) NSMutableDictionary *parametersDictionary;

@property (strong, nonatomic) NSMutableDictionary<NSString *, HiRouterCallBack> *callBackDictionary;

@property (strong, nonatomic) NSMutableDictionary<NSString *, id<HiFilterProtocol>> *filters;

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

- (NSMutableDictionary *)filters {
    
    if (!_filters) {
        _filters = [[NSMutableDictionary alloc] init];
    }
    
    return _filters;
}

- (NSMutableDictionary<NSString *,HiRouterCallBack> *)callBackDictionary {
    
    if (!_callBackDictionary) {
        
        _callBackDictionary = [[NSMutableDictionary<NSString *,HiRouterCallBack> alloc] init];
    }
    
    return _callBackDictionary;
}
/****************** lazy ******************/

#pragma mark - public
/*********** regist router ***********/
- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary {
    
    self.pRouteDictionary = routeDictionary;
}

/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */


/* 💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐💐 */


- (void)registFilter:(id<HiFilterProtocol>)filter forPath:(NSString *)path {
    
    [self.filters setObject:filter forKey:path];
}

- (NSDictionary<NSString *,NSString *> *)routeDictionary {
    
    return self.pRouteDictionary;
}
@end
