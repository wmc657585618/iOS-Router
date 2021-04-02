//
//  HiParametesViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiParametesViewController.h"
#import "HiRouterManager.h"

@interface HiParametesViewController ()
@property (nonatomic,strong) UITextView *textView;

@end

@Router(parametes/main,HiParametesViewController)
@implementation HiParametesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat x = 20;
    CGFloat width = self.view.frame.size.width - x * 2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, width, 44)];
    label.text = @"input parametes";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:label];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(label.frame) + 20, width, 140)];
    textView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    textView.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    [self.view addSubview:textView];
    self.textView = textView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [button setTitle:@"post" forState:UIControlStateNormal];
    button.frame = CGRectMake((self.view.frame.size.width - 100) * 0.5, CGRectGetMaxY(textView.frame) + 20, 100, 44);
    [button setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
}

- (void)post {
    [self hi_pushPath:parametes_main_receive withInitParameters:nil request:self.textView.text animated:true];
}

@end
