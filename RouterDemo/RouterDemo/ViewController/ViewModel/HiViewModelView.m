//
//  HiViewModelView.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiViewModelView.h"

@interface HiViewModelView ()
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIButton *button;

@end

@implementation HiViewModelView

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _textView.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    }
    return _textView;
}

- (UIButton *)button {
    
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [_button setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [_button setTitle:@"send data" forState:UIControlStateNormal];
    }
    return _button;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.textView];
        [self addSubview:self.button];
        
        [self.button addTarget:self action:@selector(sendString) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.textView.frame = CGRectMake(0, 10, frame.size.width, frame.size.height - 54);
    self.button.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame) + 5, frame.size.width, 44);
}

- (void)sendString {
    
}

- (void)received:(id)receive {

    self.textView.text = receive;
}


@end
