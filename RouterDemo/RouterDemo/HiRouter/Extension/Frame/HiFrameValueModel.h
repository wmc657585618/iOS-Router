//
//  HiFrameValueModel.h
//  RouterDemo
//
//  Created by four on 2020/5/22.
//  Copyright © 2020 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** frame 值相关 */
@interface HiFrameValueModel : NSObject

@property (nonatomic,assign) CGRect frame;

@property (nonatomic) CGFloat hi_l;
@property (nonatomic) CGFloat hi_r;
@property (nonatomic) CGFloat hi_t;
@property (nonatomic) CGFloat hi_b;
@property (nonatomic) CGFloat hi_w;
@property (nonatomic) CGFloat hi_h;
@property (nonatomic) CGFloat hi_cx;
@property (nonatomic) CGFloat hi_cy;

@property (nonatomic,readonly) CGRect hi_frame;

- (void)updateFrameValue:(CGFloat)value forAttribute:(NSLayoutAttribute)attribute;
- (CGFloat)valueForAttribute:(NSLayoutAttribute)attribute; // default 0;

@end

NS_ASSUME_NONNULL_END
