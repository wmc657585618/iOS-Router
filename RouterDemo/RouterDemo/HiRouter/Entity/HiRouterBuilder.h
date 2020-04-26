//
//  RouterBuilder.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiRouterDefine.h"

@interface HiRouterBuilder : NSObject

@property (weak, nonatomic) UIViewController *fromViewController; // maybe nil
@property (strong, nonatomic) UIViewController *targetViewController;

@property (nonatomic,assign) HiRouterTransitioningAction transitioningAction;

@property (nonatomic,assign) UIModalPresentationStyle modalPresentationStyle; // default UIModalPresentationFullScreen

// fromviewcontroller present or push toviewcontroller
// completion just for present
- (void)buildAnimated:(BOOL)animated completion:(void(^)(void))completion;

@end
