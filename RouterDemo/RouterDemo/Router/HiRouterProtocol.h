//
//  RouterProtocol.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HiRouterCommond)(NSDictionary *commond);

@protocol HiRouterViewModel <NSObject>

@optional
- (void) invorkerCommond:(HiRouterCommond)invorkerCommond;

- (void) received:(NSDictionary *)receive;

@end


