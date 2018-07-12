//
//  RouterBuilder.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface RouterBuilder : NSObject

@property (strong, nonatomic) UIViewController *viewController;

/**
 push viewController

 @param contextViewController current viewController
 */
- (void) pushWithContext:(UIViewController *)contextViewController animated:(BOOL)animated;

/**
 present viewController

 @param contextViewController current viewController
 */
- (void) presentWithContext:(UIViewController *)contextViewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

@end
