//
//  UIViewHiFrameExtension.m
//  RouterDemo
//
//  Created by four on 2020/5/18.
//  Copyright © 2020 Four. All rights reserved.
//

#import "UIViewHiFrameExtension.h"

#pragma mark - ************* property *************

@implementation UIView (HiFrame)

- (void)hi_addFrameConstraints:(HiLayoutFrameBlock)block {
    
    if (block) {
        HiFrameBuilder *builder = [[HiFrameBuilder alloc] initWithView:self];
        block(builder);
        [builder updateFrame];
    }
    
    block = nil;
}

@end
