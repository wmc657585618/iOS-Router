//
//  HiRouterFilterImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"

@implementation HiRouter (Filter)

- (NSObject<HiPageFilterProtocol> *)pageFilterWithPath:(NSString *)path {
    
    NSObject<HiPageFilterProtocol> *filter = [self.pageFilters objectForKey:path];
    
    if (filter) return filter;
    
    NSArray *pathes = [path componentsSeparatedByString:@"/"];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:pathes];
    
    for (NSInteger i = 0; i < pathes.count; i ++) {
        
        NSString *key = [mArray componentsJoinedByString:@"/"];
        
        NSObject<HiPageFilterProtocol> *filter = [self.pageFilters objectForKey:[[NSString alloc] initWithFormat:@"%@*",key]];
        
        filter.originPath = path;
        if (filter) return filter;
        
        [mArray removeLastObject];
    }
    
    return [self.pageFilters objectForKey:@"*"];
}

- (NSObject<HiNetworkFilterProtocol> *)nwtworkFilterWithPath:(NSString *)path {
    
    NSObject<HiNetworkFilterProtocol> *filter = [self.networkFilters objectForKey:path];
    
    filter.originPath = path;
    if (filter) return filter;
    
    NSArray *pathes = [path componentsSeparatedByString:@"/"];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:pathes];
    
    for (NSInteger i = 0; i < pathes.count; i ++) {
        
        NSString *key = [mArray componentsJoinedByString:@"/"];
        
        NSObject<HiNetworkFilterProtocol> *filter = [self.networkFilters objectForKey:[[NSString alloc] initWithFormat:@"%@*",key]];
        
        filter.originPath = path;
        if (filter) return filter;
        
        [mArray removeLastObject];
    }
    
    return [self.networkFilters objectForKey:@"*"];
}

@end
