//
//  HiRouterDefine.h
//  RouterDemo
//
//  Created by four on 2018/12/18.
//  Copyright © 2018 Four. All rights reserved.
//

#ifndef HiRouterDefine_h
#define HiRouterDefine_h

typedef enum : NSUInteger {
    HiRouterTransitionNone,
    HiRouterTransitionPush,
    HiRouterTransitionPresent,
} HiRouterTransition;

struct HiFilterBody {
    NSString *path;
    HiRouterTransition transition;
    UIModalPresentationStyle modal;
    id parameters; // init 参数
    id request;
};

typedef struct HiFilterBody HiFilterBody;

static inline HiFilterBody hiFilterMake(NSString *path, id parameters) {
    HiFilterBody body;
    body.path = path;
    body.parameters = parameters;
    body.transition = HiRouterTransitionNone;
    body.modal = UIModalPresentationFullScreen;

    return body;
}

static inline HiFilterBody hiFilterTransitioningMake(NSString *path, id parameters, HiRouterTransition transition, UIModalPresentationStyle modal) {
    HiFilterBody body;
    body.path = path;
    body.parameters = parameters;
    body.transition = transition;
    body.modal = modal;
    return body;
}

#endif /* HiRouterDefine_h */
