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
    id parameters; // init 参数
    id request;
    id other;
};

typedef struct HiFilterBody HiFilterBody;

static inline HiFilterBody hiFilterMake(NSString *path, id parameters, id request, id other) {
    HiFilterBody body;
    body.path = path;
    body.parameters = parameters;
    body.request = request;
    body.other = other;
    
    return body;
}


struct HiFilterTransitionBody {
    NSString *path;
    HiRouterTransition transition;
    id parameters; // init 参数
    id request;
    id other;
};

typedef struct HiFilterTransitionBody HiFilterTransitionBody;

static inline HiFilterTransitionBody hiFilterTransitioningMake(NSString *path, id parameters, id request, id other, HiRouterTransition transition) {
    HiFilterTransitionBody body;
    body.path = path;
    body.parameters = parameters;
    body.request = request;
    body.other = other;
    body.transition = transition;
    return body;
}

#define Router(_var_) interface


#endif /* HiRouterDefine_h */
