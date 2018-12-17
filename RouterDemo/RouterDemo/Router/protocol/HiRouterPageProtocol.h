//
//  HiRouterPageProtocol.h
//  RouterDemo
//
//  Created by four on 2018/11/12.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HiRouterPageProtocol <NSObject>

@optional
- (void)recivedParameters:(id)parameters;

- (void)recivedCallBack:(id)callBack;

@end
