//
//  NSObjectHiFilter.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "NSObjectHiFilter.h"
#import "HiRouterPrivate.h"

@implementation NSObject (HiFilter)

- (void)becomeFilter {
    if ([self conformsToProtocol:@protocol(HiFilter)] && ![self.hi_filterChain containsObject:self]) {
        [self.hi_filterChain addObject:self];
    }
}

+ (void)becomeFilter {
    if ([self conformsToProtocol:@protocol(HiFilter)] && ![self.hi_filterChain containsObject:self]) {
        [self.hi_filterChain addObject:self];
    }
}

@end
