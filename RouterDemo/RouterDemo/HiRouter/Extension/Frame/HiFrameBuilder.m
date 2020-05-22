//
//  HiFrameBuilder.m
//  ZYBScanSearch
//
//  Created by four on 2020/5/21.
//  Copyright © 2020 zuoyebang. All rights reserved.
//

#import "HiFrameBuilder.h"
#import "UIViewHiCommon.h"
#import "HiFrameOptionManager.h"

@interface HiFrameBuilder ()

@property (nonatomic,weak) UIView *view;

@property (nonatomic,assign,readonly) CGRect frame;
@property (nonatomic,assign,readonly) CGRect bounds;

@property (nonatomic,strong) HiFrameOptionManager *optionManager;

@end


@implementation HiFrameBuilder

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        _view = view;
    }
    return self;
}

- (HiFrameOptionManager *)optionManager {
    if(!_optionManager) _optionManager = [[HiFrameOptionManager alloc] initWitView:self.view];
    return _optionManager;
}

- (void)updateFrame{

    HiFrameStruct st = self.optionManager.frameStruct;
    if (st.available) self.view.frame = st.frame;
}

#pragma mark - public
- (HiFrameRelatedModel *)modelForAttribute:(NSLayoutAttribute)attribute{
    HiFrameRelatedModel *model = [[HiFrameRelatedModel alloc] initWithOption:self.optionManager attribute:attribute];
    [self.optionManager optionWithAttribute:attribute];
    return model;
}

- (HiFrameRelatedModel *)hi_left {
    return [self modelForAttribute:NSLayoutAttributeLeft];
}

- (HiFrameRelatedModel *)hi_right {
    return [self modelForAttribute:NSLayoutAttributeRight];
}

- (HiFrameRelatedModel *)hi_top {
    return [self modelForAttribute:NSLayoutAttributeTop];
}

- (HiFrameRelatedModel *)hi_bottom {
    return [self modelForAttribute:NSLayoutAttributeBottom];
}

- (HiFrameRelatedModel *)hi_width {
    return [self modelForAttribute:NSLayoutAttributeWidth];
}

- (HiFrameRelatedModel *)hi_height {
    return [self modelForAttribute:NSLayoutAttributeHeight];
}

- (HiFrameRelatedModel *)hi_centerX {
    return [self modelForAttribute:NSLayoutAttributeCenterX];
}

- (HiFrameRelatedModel *)hi_centerY {
    return [self modelForAttribute:NSLayoutAttributeCenterY];
}

@end
