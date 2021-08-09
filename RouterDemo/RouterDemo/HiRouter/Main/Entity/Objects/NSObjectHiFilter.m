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
    if ([self conformsToProtocol:@protocol(HiFilter)]) {
        if (!self.hi_filter) self.hi_filter = self;
    }
}

+ (void)becomeFilter {
    if ([self conformsToProtocol:@protocol(HiFilter)]) {
        if (!self.hi_filter) self.hi_filter = self;
    }
}

@end
