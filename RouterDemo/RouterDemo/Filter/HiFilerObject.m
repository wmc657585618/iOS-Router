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

- (NSString *)filtPath {
    return @"login";
}

- (NSString *)originPath {
    return self.pOriginPath;
}

- (void)setOriginPath:(NSString *)originPath {
    self.pOriginPath = originPath;
}

- (NSString *)forwardPath {
    return @"parameters";
}

- (id)defaultParameters {
    
    return @{@"key":@"default"};
}

- (HiRouterNavigationAction)navigationAction {
    
    return HiRouterNavigationActionPush;
}

@end
