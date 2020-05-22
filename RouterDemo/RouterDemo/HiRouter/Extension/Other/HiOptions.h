//
//  HiOptions.h
//  RouterDemo
//
//  Created by four on 2020/5/22.
//  Copyright © 2020 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, HiViewOptions) {
    HiViewOptionsLeft = 1 << 0,
    HiViewOptionsRight = 1 << 1,
    HiViewOptionsTop = 1 << 2,
    HiViewOptionsBottom = 1 << 3,
    HiViewOptionsWidth = 1 << 4,
    HiViewOptionsHeight = 1 << 5,
    HiViewOptionsCenterX = 1 << 6,
    HiViewOptionsCenterY = 1 << 7,
    HiViewOptionsNone = 1 << 8
};

NS_ASSUME_NONNULL_BEGIN

@interface HiOptions : NSObject

// view 的组合是否可用
+ (BOOL)availableViewOptions:(HiViewOptions)options;

+ (HiViewOptions)viewOptions:(HiViewOptions)options forAttribute:(NSLayoutAttribute)attribute;

@end

NS_ASSUME_NONNULL_END
