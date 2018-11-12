//
//  RouterProtocol.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HiRouterViewModel <NSObject>

- (void) received:(id)receive;

// this delegate has implemented
@optional
@property(nonatomic,weak) id<HiRouterViewModel>hi_private_delegate;

@end

