//
//  HiNetworkFilter.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiNetworkFilter.h"


@implementation HiNetworkFilter

- (NSString *)filterRegex {
    
    return self.filter;
}

- (NSUInteger)priority {
    
    return 100;
}

- (NSString *)forwardPath {
    
    return self.forward;
}

- (NSString *)originPath {
    
    return @"";
}

- (void)setOriginPath:(NSString *)originPath {
    
}

- (NSString *)result {
    
    return @"post";
}

- (id)parameters {
    return @"";
}

- (void)setParameters:(id)parameters {
    
}

@end

