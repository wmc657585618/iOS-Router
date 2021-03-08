//
//  Router.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterProtocol.h"
#import <UIKit/UIKit.h>

@interface NSString (HiPathClass)

@property (nonatomic,strong) Class hi_class;

@end

@interface NSObject (HiRouter)

+ (id)objectForPath:(NSString *)path;

+ (id)objectForPath:(NSString *)path withInitParameters:(id)parameters;

+ (id)objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;

- (id)objectForPath:(NSString *)path;

- (id)objectForPath:(NSString *)path withInitParameters:(id)parameters;

- (id)objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;

- (void)makeResponse:(id)response;

+ (void)registFilter:(id<HiFilter>)filter;

@end


@interface UIViewController (HiRouter)

- (id)pushPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated;

- (id)presentPath:(NSString *)path withInitParameters:(id)parameters request:(id)request animated:(BOOL)animated completion:(void (^)(void))completion;
@end

