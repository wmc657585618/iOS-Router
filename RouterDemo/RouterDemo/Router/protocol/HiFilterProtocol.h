//
//  HiFilterProtocol.h
//  RouterDemo
//
//  Created by four on 2018/11/6.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterDefine.h"

@protocol HiFilterProtocol <NSObject>

@property (nonatomic,readonly) NSUInteger priority;
@property (nonatomic,readonly) NSString *filterRegex;

@property (nonatomic,copy) NSString *originPath;
@property (nonatomic,readonly) NSString *forwardPath;

@property (nonatomic,strong) id parameters;

@end

@protocol HiPageFilterProtocol <HiFilterProtocol>

@property (nonatomic,readonly) HiRouterNavigationAction navigationAction;

@end

@protocol HiNetworkFilterProtocol <HiFilterProtocol>

@property (nonatomic,readonly) NSString *result; // like method get post put ...

@end
