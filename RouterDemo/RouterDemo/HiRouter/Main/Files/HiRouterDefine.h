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
    id parameters; // init 参数
    id request;
};

typedef struct HiFilterBody HiFilterBody;

static inline HiFilterBody hiFilterMake(NSString *path, id parameters) {
    HiFilterBody body;
    body.path = path;
    body.parameters = parameters;
    body.transition = HiRouterTransitionNone;
    
    return body;
}

static inline HiFilterBody hiFilterTransitioningMake(NSString *path, id parameters, HiRouterTransition transition) {
    HiFilterBody body;
    body.path = path;
    body.parameters = parameters;
    body.transition = transition;
    return body;
}

#endif /* HiRouterDefine_h */
