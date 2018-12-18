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
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSString *> *pRouteDictionary;

@property (strong, nonatomic) NSMutableDictionary<NSString *, NSObject<HiFilterProtocol> *> *pFilters;

@property (strong, nonatomic) NSLock *filterLock;
@property (strong, nonatomic) NSLock *routerLock;
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

/****************** lazy ******************/
- (NSMutableDictionary<NSString *,NSString *> *)pRouteDictionary {
    
    if (!_pRouteDictionary) {
        _pRouteDictionary = [NSMutableDictionary dictionary];
    }
    return _pRouteDictionary;
}

- (NSMutableDictionary *)pFilters {
    
    if (!_pFilters) {
        _pFilters = [[NSMutableDictionary alloc] init];
    }
    return _pFilters;
}

- (NSLock *)filterLock {
    
    if (!_filterLock) {
        _filterLock = [[NSLock alloc] init];
    }
    return _filterLock;
}

- (NSLock *)routerLock {
    
    if (!_routerLock) {
        _routerLock = [[NSLock alloc] init];
    }
    return _routerLock;
}

/****************** lazy ******************/

#pragma mark - public
/*********** regist router ***********/
- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary {
    
    [self.routerLock lock];
    
    [self.pRouteDictionary addEntriesFromDictionary:routeDictionary];
    
    [self.routerLock unlock];
}

- (void)registFilter:(NSObject<HiFilterProtocol> *)filter {
    
    [self.filterLock lock];
    
    if (filter.originPath) {
        [self.pFilters setObject:filter forKey:filter.originPath];
    }
    
    [self.filterLock unlock];
}

- (NSDictionary<NSString *,NSString *> *)routeDictionary {
    
    return self.pRouteDictionary;
}

- (NSDictionary *)filters {
    
    return self.pFilters;
}

@end
