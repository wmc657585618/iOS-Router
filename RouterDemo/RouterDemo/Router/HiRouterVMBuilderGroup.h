//
//  RouterVMBuilderGroup.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HiRouterVMBuilder.h"

@interface HiRouterVMBuilderGroup : NSObject

- (void) setVMBuilder:(HiRouterVMBuilder *)builder forKey:(NSString *)key;

/*
 maybe return is nill
 */
- (HiRouterVMBuilder *) vmBuilderForKey:(NSString *)key;

@property (readonly, nonatomic) NSArray *allBuilders;

@end
