//
//  NSObjectHiCategory.h
//  RouterDemo
//
//  Created by four on 2018/12/25.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HiRouter)<HiRouterViewModel>

- (void)hi_bindObject:(NSObject<HiRouterViewModel> *)object;

- (void)hi_postData:(id)data;

@end

// dealloc
@interface NSObject (HiDealloc)<HiRouterViewModel>

- (void)hi_bindObject:(NSObject<HiRouterViewModel> *)object;

- (void)hi_postData:(id)data;

@end

@interface NSString (HiPredicate)

-(BOOL)isValidateRegularByExpression:(NSString *)strExpression;

@end

@interface UIViewController (HiRouter)<HiRouterPageProtocol>

// push
// delegate
- (void)hi_pushPath:(NSString *)path animated:(BOOL)animated;

- (void)hi_pushPath:(NSString *)path withParameters:(id)parameters animated:(BOOL)animated;

// block
- (void)hi_pushPath:(NSString *)path animated:(BOOL)animated block:(void(^)(id parameters))block;

- (void)hi_pushPath:(NSString *)path withParameters:(id)parameters animated:(BOOL)animated block:(void(^)(id parameters))block;

// present
// delegate
- (void)hi_presentPath:(NSString *)path modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle  animated:(BOOL)animated completion:(void(^)(void))completion;

- (void)hi_presentPath:(NSString *)path modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle  withParameters:(id)parametes animated:(BOOL)animated completion:(void(^)(void))completion;

// block
- (void)hi_presentPath:(NSString *)path modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle withParameters:(id)parametes animated:(BOOL)animated completion:(void(^)(void))completion block:(void(^)(id parameters))block;

- (void)hi_presentPath:(NSString *)path modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle animated:(BOOL)animated completion:(void(^)(void))completion block:(void(^)(id parameters))block;

// call back
- (HiRouterCallBackType)hi_callBackParameters:(id)callBackParameters;

// pop to last path
- (NSError *)hi_popToPath:(NSString *)path animated:(BOOL)animated;
- (NSError *)hi_popToPath:(NSString *)path parameters:(id)parameters animated:(BOOL)animated;

// remove last path
- (NSError *)hi_removePath:(NSString *)path;
- (NSError *)hi_removePath:(NSString *)path parameters:(id)parameters;

// notify last path
- (NSError *)hi_postParameters:(id)parameters toPath:(NSString *)path;

/**
 last created viewController for path
 */
- (UIViewController<HiRouterPageProtocol> *)hi_topViewControllerForPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
