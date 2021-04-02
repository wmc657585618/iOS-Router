//
//  HiViewModelViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiViewModelViewController.h"
#import "HiViewModelView.h"
#import "HiViewModelReceiveView.h"

@interface HiViewModelViewController ()
@property (nonatomic,strong) HiViewModelView *vmView;
@property (nonatomic,strong) HiViewModelReceiveView *receiveView;

@end

@Router(viewmodel,HiViewModelViewController)
@implementation HiViewModelViewController

- (HiViewModelView *)vmView {
    
    if (!_vmView) {
        _vmView = [[HiViewModelView alloc] init];
    }
    return _vmView;
}

- (HiViewModelReceiveView *)receiveView {
    if (!_receiveView) {
        _receiveView = [[HiViewModelReceiveView alloc] init];
    }
    return _receiveView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;

    CGFloat x = 20;
    CGFloat width = self.view.frame.size.width - x * 2;
    
    self.vmView.frame = CGRectMake(x, 100, width, 180);
    [self.view addSubview:self.vmView];
    
    self.receiveView.frame = CGRectMake(x, CGRectGetMaxY(self.vmView.frame) + 40, width, 224);
    [self.view addSubview:self.receiveView];
    
}

@end
