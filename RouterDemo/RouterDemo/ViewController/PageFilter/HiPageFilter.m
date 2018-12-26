//
//  HiPageFilter.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiPageFilter.h"

@implementation HiPageFilter

- (instancetype)initWithFilerRegex:(NSString *)regex
{
    self = [super init];
    if (self) {
        _regex = regex;
    }
    return self;
}

- (NSString *)filterRegex {
    
    return self.regex;
}

- (NSUInteger)priority {
    
    return 100;
}

- (NSString *)forwardPath {
    
    return @"page/error";
}

- (NSString *)originPath {
    
    return @"";
}

- (void)setOriginPath:(NSString *)originPath {
    
}

- (HiRouterTransitioningAction) transitioningAction{
   
    return HiRouterTransitioningActionPush;
}

- (id)parameters {
    return @"";
}

- (void)setParameters:(id)parameters {
    
}
@end
