//
//  RouterProtocol.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RouterCommond)(NSDictionary *commond);

@protocol RouterViewModel <NSObject>

@optional
- (void) invorkerCommond:(RouterCommond)invorkerCommond;

- (void) received:(NSDictionary *)receive;

@end


