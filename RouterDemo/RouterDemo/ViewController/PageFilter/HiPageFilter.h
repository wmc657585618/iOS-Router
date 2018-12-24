//
//  HiPageFilter.h
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiPageFilter : NSObject<HiPageFilterProtocol>
@property (nonatomic,copy) NSString *regex;
- (instancetype)initWithFilerRegex:(NSString *)regex;
@end

NS_ASSUME_NONNULL_END
