//
//  HiPageFilterViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiPageFilterViewController.h"
#import "HiRouterManager.h"
#import "HiPageFilter.h"

@interface HiPageFilterViewController ()
@property (nonatomic,strong) HiPageFilter *pageSub1Filer;
@property (nonatomic,strong) HiPageFilter *pageSub2Filer;
@property (nonatomic,strong) HiPageFilter *pageAllFiler;

@end

@implementation HiPageFilterViewController

- (HiPageFilter *)pageSub1Filer {
    
    if (!_pageSub1Filer) {
        _pageSub1Filer = [[HiPageFilter alloc] initWithFilerRegex:@"sub1default"];
    }
    return _pageSub1Filer;
}

- (HiPageFilter *)pageSub2Filer {
    
    if (!_pageSub2Filer) {
        _pageSub2Filer = [[HiPageFilter alloc] initWithFilerRegex:@"sub2default"];
    }
    return _pageSub2Filer;
}

- (HiPageFilter *)pageAllFiler {
    
    if (!_pageAllFiler) {
        _pageAllFiler = [[HiPageFilter alloc] initWithFilerRegex:@"alldefault"];
    }
    return _pageAllFiler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *errorButton = [self buttonWithTiltel:@"push to error" y:100];
    [errorButton addTarget:self action:@selector(push2Erro) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:errorButton];
    
    UIButton *sub1Button = [self buttonWithTiltel:@"push to sub1" y:CGRectGetMaxY(errorButton.frame) + 20];
    [sub1Button addTarget:self action:@selector(push2Sub1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sub1Button];
    
    UIButton *sub2Button = [self buttonWithTiltel:@"push to sub2" y:CGRectGetMaxY(sub1Button.frame) + 20];
    [sub2Button addTarget:self action:@selector(push2Sub2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sub2Button];
    
    UIButton *filterSub1Button = [self buttonWithTiltel:@"filter sub1" y:CGRectGetMaxY(sub2Button.frame) + 20];
    [filterSub1Button setTitle:@"click sub1" forState:UIControlStateSelected];
    [filterSub1Button addTarget:self action:@selector(filterSub1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filterSub1Button];
    
    UIButton *filterSub2Button = [self buttonWithTiltel:@"filter sub2" y:CGRectGetMaxY(filterSub1Button.frame) + 20];
    [filterSub2Button setTitle:@"click sub2" forState:UIControlStateSelected];
    [filterSub2Button addTarget:self action:@selector(filterSub2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filterSub2Button];
    
    UIButton *filterAllSub = [self buttonWithTiltel:@"filter all sub" y:CGRectGetMaxY(filterSub2Button.frame) + 20];
    [filterAllSub setTitle:@"click sub1 or sub2" forState:UIControlStateSelected];
    [filterAllSub addTarget:self action:@selector(filterAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filterAllSub];
}

- (UIButton *)buttonWithTiltel:(NSString *)title y:(CGFloat)y {
    
    CGFloat x = 20;
    CGFloat width = self.view.frame.size.width - 2 * x;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(x, y, width, 44);
    button.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColor.grayColor forState:UIControlStateNormal];

    return button;
}

- (void)push2Erro {
}

- (void)push2Sub1 {
}

- (void)push2Sub2 {
}

- (void)filterSub1:(UIButton *)button {
    button.selected = !button.isSelected;
    
}

- (void)filterSub2:(UIButton *)button {
    button.selected = !button.isSelected;
    
}

- (void)filterAll:(UIButton *)button {
    button.selected = !button.isSelected;
    self.pageAllFiler.regex = button.selected ? @"^page/sub/.+" : @"none";
}

@end
