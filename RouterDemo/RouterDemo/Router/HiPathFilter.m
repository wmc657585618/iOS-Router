//
//  HiPathFilter.m
//  RouterDemo
//
//  Created by four on 2018/11/6.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiPathFilter.h"
#import "HiPageRouter.h"

@implementation HiPathFilter
- (instancetype)init
{
    self = [super init];
    if (self) {
        _pagePre = @"Hipage";
    }
    return self;
}

- (void)pathFilterWithURL:(NSURL *)url {
    
    NSString *scheme = url.scheme;
//    NSString *host = url.host;
//    NSString *path = url.path;
//    NSString *terminal = url.lastPathComponent;
//    NSString *query = url.query;
//    NSNumber *port = url.port;
    
    if ([scheme isEqualToString:self.pagePre]) {
        
    } else {
        
    }
}

@end
