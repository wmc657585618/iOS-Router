//
//  NSObject+HiRouter.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "NSObject+HiRouter.h"

@implementation NSObject (HiRouter)

- (void)bindObject:(NSObject<HiRouterViewModel> *)object {

    [HiRouter.instance buildViewModelInDynamic:self objectB:object];
}

- (void)postData:(id)data {

    [HiRouter.instance invork:self postData:data];
}

@end
