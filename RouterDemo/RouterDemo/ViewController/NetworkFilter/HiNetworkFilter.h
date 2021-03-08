//
//  HiNetworkFilter.h
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiNetworkFilter : NSObject

@property (nonatomic,copy) NSString *filter;
@property (nonatomic,copy) NSString *forward;

@end

NS_ASSUME_NONNULL_END
