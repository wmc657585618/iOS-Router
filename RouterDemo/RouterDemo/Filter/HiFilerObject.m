//
//  HiFilerObject.m
//  RouterDemo
//
//  Created by four on 2018/12/17.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiFilerObject.h"

@interface HiFilerObject ()
@property (nonatomic,copy) NSString *pOriginPath;

@end

@implementation HiFilerObject

- (NSString *)filterRegex {
    return @"login";
}

- (NSString *)originPath {
    return self.pOriginPath;
}

- (NSUInteger)priority {
    
    return 1000;
}

- (void)setOriginPath:(NSString *)originPath {
    self.pOriginPath = originPath;
}

- (NSString *)forwardPath {
    return @"parameters";
}

- (id)parameters {
    
    return @{@"key":@"default"};
}

- (void)setParameters:(id)parameters {
    
}

- (HiRouterNavigationAction)navigationAction {
    
    return HiRouterNavigationActionPush;
}

@end
