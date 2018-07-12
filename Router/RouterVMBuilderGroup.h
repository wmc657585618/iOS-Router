//
//  RouterVMBuilderGroup.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RouterVMBuilder.h"

@interface RouterVMBuilderGroup : NSObject

- (void) setVMBuilder:(RouterVMBuilder *)builder forKey:(NSString *)key;

/*
 maybe return is nill
 */
- (RouterVMBuilder *) vmBuilderForKey:(NSString *)key;

@property (readonly, nonatomic) NSArray *allBuilders;

@end
