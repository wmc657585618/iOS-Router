//
//  NSObject+HiRouter.h
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HiRouter)<HiRouterViewModel>

- (void)bindObject:(NSObject<HiRouterViewModel> *)object;

- (void)postData:(id)data;

@end

NS_ASSUME_NONNULL_END
