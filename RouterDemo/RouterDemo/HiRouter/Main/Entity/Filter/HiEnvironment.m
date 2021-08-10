//
//  HiEnvironment.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiEnvironment.h"
#import "HiURN.h"

@interface HiEnvironment ()

@property (nonatomic, assign) BOOL isBreak;
@property (nonatomic, strong) HiURN *urn;

@end

@implementation HiEnvironment

- (HiURN *)urn {
    if (!_urn) {
        _urn = [[HiURN alloc] init];
    }
    return _urn;
}

- (void)breakChain {
    self.isBreak = true;
}

- (void)setPath:(NSString *)path {
    [super setPath:path];
    self.urn.path = path;
}

@end
