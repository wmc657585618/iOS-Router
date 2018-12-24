//
//  HiRootTableModel.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRootTableModel.h"

@implementation HiRootTableModel
- (instancetype)initWithTitle:(NSString *)title type:(HiRootTableModelType)type
{
    self = [super init];
    if (self) {
        _title = title;
        _type = type;
    }
    return self;
}
@end
