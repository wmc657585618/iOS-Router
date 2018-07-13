//
//  RouterVMBuilderGroup.m
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterVMBuilderGroup.h"

@interface HiRouterVMBuilderGroup ()

@property (strong, nonatomic) NSMutableDictionary<NSString *, HiRouterVMBuilder *> *buildersDictionary;

@end

@implementation HiRouterVMBuilderGroup

- (NSMutableDictionary<NSString *, HiRouterVMBuilder *> *)buildersDictionary {
    
    if (!_buildersDictionary) {
        
        _buildersDictionary = [[NSMutableDictionary<NSString *, HiRouterVMBuilder *> alloc] init];
    }
    
    return _buildersDictionary;
}

- (void) setVMBuilder:(HiRouterVMBuilder *)builder forKey:(NSString *)key {
    
    [self.buildersDictionary setObject:builder forKey:key];
}

- (HiRouterVMBuilder *) vmBuilderForKey:(NSString *)key {
    
    return [self.buildersDictionary objectForKey:key];
}

- (NSArray *)allBuilders {
    
    return self.buildersDictionary.allValues;
}

@end
