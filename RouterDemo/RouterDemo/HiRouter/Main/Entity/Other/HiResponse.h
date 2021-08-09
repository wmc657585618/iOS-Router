//
//  HiResponse.h
//  RouterDemo
//
//  Created by four on 2021/8/9.
//  Copyright © 2021 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiRouterDefine.h"

@interface HiResponse : NSObject

@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) HiRouterTransition transition;
@property (nonatomic, assign) UIModalPresentationStyle modal;
@property (nonatomic, strong) id parameters; // init 参数
@property (nonatomic, strong) id request;

@end

static inline HiResponse * hiFilterTransitioningMake(NSString *path, id parameters, HiRouterTransition transition, UIModalPresentationStyle modal) {
    HiResponse *body = [[HiResponse alloc] init];
    body.path = path;
    body.parameters = parameters;
    body.transition = transition;
    body.modal = modal;
    return body;
}

static inline HiResponse * hiFilterMake(NSString *path, id parameters) {
    return hiFilterTransitioningMake(path, parameters, HiRouterTransitionNone, UIModalPresentationFullScreen);
}

