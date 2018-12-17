//
//  HiFilerObject.m
//  RouterDemo
//
//  Created by four on 2018/12/17.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiFilerObject.h"

@implementation HiFilerObject

- (NSString *)originPath {
    return @"login";
}

- (NSString *)forwardPath {
    return @"parameters";
}

- (id)defaultParameters {
    
    return @{@"key":@"default"};
}
@end
