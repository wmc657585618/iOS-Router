//
//  HiNetworkFilterViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiNetworkFilterViewController.h"
#import "HiRouterManager.h"
#import "HiNetworkFilter.h"

@interface HiNetworkFilterViewController ()
@property (nonatomic,strong) UITextField *urlField;
@property (nonatomic,strong) UITextField *filterField;
@property (nonatomic,strong) UILabel *filterLabel;
@property (nonatomic,strong) UITextField *resultField;

@property (nonatomic,strong) HiNetworkFilter *filter;

@end

@implementation HiNetworkFilterViewController

- (HiNetworkFilter *)filter {
    
    if (!_filter) {
        _filter = [[HiNetworkFilter alloc] init];
    }
    return _filter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat x = 20;
    CGFloat width = self.view.frame.size.width - x * 2;
    
    UITextField *urlField = [[UITextField alloc] initWithFrame:CGRectMake(x, 100, width, 44)];
    urlField.placeholder = @"input a url like https://...";
    urlField.backgroundColor = UIColor.groupTableViewBackgroundColor;
    urlField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:urlField];

    UITextField *filterField = [[UITextField alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(urlField.frame) + 20, width, 44)];
    filterField.placeholder = @"input a regex like ^https://.+";
    filterField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    filterField.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:filterField];

    UITextField *resultField = [[UITextField alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(filterField.frame) + 20, width, 44)];
    resultField.placeholder = @"input a forwardpath like www.google.com";
    resultField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    resultField.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:resultField];
    
    UILabel *filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(resultField.frame) + 20, width, 44)];
    filterLabel.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:filterLabel];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [button setTitle:@"filter" forState:UIControlStateNormal];
    button.frame = CGRectMake(x, CGRectGetMaxY(filterLabel.frame) + 20, width, 44);
    [button setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    
    self.filter.filter = @"te";
    
    self.urlField = urlField;
    self.filterField = filterField;
    self.filterLabel = filterLabel;
    self.resultField = resultField;
}

- (void)change {
    
    self.filter.forward = self.resultField.text;
    self.filter.filter = self.filterField.text;
}


@end
