//
//  HiEnvironment.m
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import "HiEnvironment.h"

@interface HiEnvironment ()

@property (nonatomic, assign) BOOL isBreak;

@end

@implementation HiEnvironment

- (void)breakChain {
    self.isBreak = true;
}

@end
