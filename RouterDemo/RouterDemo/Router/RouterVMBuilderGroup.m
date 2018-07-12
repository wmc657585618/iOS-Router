//
//  RouterVMBuilderGroup.m
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "RouterVMBuilderGroup.h"

@interface RouterVMBuilderGroup ()

@property (strong, nonatomic) NSMutableDictionary<NSString *, RouterVMBuilder *> *buildersDictionary;

@end

@implementation RouterVMBuilderGroup

- (NSMutableDictionary<NSString *, RouterVMBuilder *> *)buildersDictionary {
    
    if (!_buildersDictionary) {
        
        _buildersDictionary = [[NSMutableDictionary<NSString *, RouterVMBuilder *> alloc] init];
    }
    
    return _buildersDictionary;
}

- (void) setVMBuilder:(RouterVMBuilder *)builder forKey:(NSString *)key {
    
    [self.buildersDictionary setObject:builder forKey:key];
}

- (RouterVMBuilder *) vmBuilderForKey:(NSString *)key {
    
    return [self.buildersDictionary objectForKey:key];
}

- (NSArray *)allBuilders {
    
    return self.buildersDictionary.allValues;
}

@end
