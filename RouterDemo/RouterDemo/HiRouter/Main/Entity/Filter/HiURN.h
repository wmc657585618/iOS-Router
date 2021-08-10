//
//  HiURN.h
//  RouterDemo
//
//  Created by four on 2021/8/10.
//  Copyright © 2021 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiFilterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiURN : NSObject<HiFilterURN>

@property (nullable, copy) NSString *scheme;
@property (nullable, copy) NSString *path;

@end

NS_ASSUME_NONNULL_END
