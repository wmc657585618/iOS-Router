//
//  HiParametesReceiveViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiParametesReceiveViewController.h"
#import "HiRouterManager.h"

@interface HiParametesReceiveViewController ()
@property (nonatomic,strong) UILabel *receiveLabel;

@end

@implementation HiParametesReceiveViewController

- (UILabel *)receiveLabel {
    
    if (!_receiveLabel) {
        _receiveLabel = [[UILabel alloc] init];
    }
    return _receiveLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat x = 20;
    CGFloat width = self.view.frame.size.width - x * 2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, width, 44)];
    label.text = @"get parametes";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:label];
    
    self.receiveLabel.frame = CGRectMake(x, CGRectGetMaxY(label.frame) + 20, width, 140);
    self.receiveLabel.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:self.receiveLabel];
}

- (id)hi_request:(id)request {
    self.receiveLabel.text = request;
    return nil;
    
}

@end
