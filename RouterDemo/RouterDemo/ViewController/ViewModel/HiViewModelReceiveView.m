//
//  HiViewModelReceiveView.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiViewModelReceiveView.h"

@interface HiViewModelReceiveView ()

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation HiViewModelReceiveView

- (UILabel *)titleLabel {

    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"receive data";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColor.grayColor;
        _titleLabel.backgroundColor = UIColor.groupTableViewBackgroundColor;
    }
    return _titleLabel;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _textView.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    }
    return _textView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        [self addSubview:self.textView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    self.titleLabel.frame = CGRectMake(0, 0, frame.size.width, 44);

    self.textView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 10, frame.size.width, frame.size.height - 54);
}

- (void)received:(id)receive {

    self.textView.text = receive;
}

@end
