//
//  HiFrameOptionManager.m
//  RouterDemo
//
//  Created by four on 2020/5/21.
//  Copyright © 2020 Four. All rights reserved.
//

#import "HiFrameOptionManager.h"
#import "HiOptions.h"
#import "HiFrameValueModel.h"

@interface HiFrameOptionManager ()

@property (nonatomic,strong) HiFrameValueModel *frameValue;

@property (nonatomic,assign) HiViewOptions options;
@property (nonatomic,weak) UIView *pView;

@end

@implementation HiFrameOptionManager

- (HiFrameValueModel *)frameValue {
    if(!_frameValue) _frameValue = [[HiFrameValueModel alloc] init];
    return _frameValue;
}

- (instancetype)initWitView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.frameValue.frame = view.frame;
        _pView = view;
        _options = HiViewOptionsNone;
    }
    return self;
}

- (HiFrameStruct)getFrameForOptions:(HiViewOptions)options{
    
    CGRect frame = CGRectZero;
    BOOL available = [HiOptions availableViewOptions:options];
    if (available) frame = self.frameValue.hi_frame;
    HiFrameStruct st;
    st.frame = frame;
    st.available = available;
    return st;
}

- (void)optionWithAttribute:(NSLayoutAttribute)attribute{
    self.options = [HiOptions viewOptions:self.options forAttribute:attribute];
}

// 更新 x y w h
- (void)updateFrameValue:(CGFloat)value forAttribute:(NSLayoutAttribute)attribute {
    [self.frameValue updateFrameValue:value forAttribute:attribute];
}

- (CGFloat)selfValueForAttribute:(NSLayoutAttribute)attribute{
    return [self.frameValue valueForAttribute:attribute];
}

- (CGFloat)frameValueForAttribute:(NSLayoutAttribute)attribute {
    return [self selfValueForAttribute:attribute];
}

- (HiFrameStruct)frameStruct {
    return [self getFrameForOptions:self.options];
}

- (UIView *)view {
    return self.pView;
}

@end
