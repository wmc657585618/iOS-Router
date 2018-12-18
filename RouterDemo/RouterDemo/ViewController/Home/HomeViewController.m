//
//  HomeViewController.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HomeViewController.h"

#import "HiRouterManager.h"

@interface HomeViewController ()<HiRouterPageProtocol>

@property (strong, nonatomic) UILabel *displayLabel;

@end

@implementation HomeViewController

- (UILabel *)displayLabel {
    
    if (!_displayLabel) {
        
        _displayLabel = [[UILabel alloc] init];
        
        _displayLabel.numberOfLines = 0;
        
        _displayLabel.backgroundColor = [UIColor colorWithRed:173 / 255.0 green:216 / 255.0 blue:230 / 255.0 alpha:1];
    }
    
    return _displayLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:228 / 255.0 blue:196 / 255.0 alpha:1];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    loginButton.frame = CGRectMake(20, 100, 100, 100);
    
    [loginButton addTarget:self action:@selector(showLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    button.frame = CGRectMake(200, 100, 100, 100);
    
    [button addTarget:self action:@selector(parameters) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    self.displayLabel.frame = CGRectMake(10, CGRectGetMaxY(button.frame), self.view.bounds.size.width - 20, 100);
    
    [self.view addSubview:self.displayLabel];
}

- (void) showLogin {
    
    [[HiRouter.instance build:@"login" fromViewController:self action:HiRouterNavigationActionPresent] buildAnimated:true completion:^{
        
    }];
}

- (void)recivedCallBack:(NSDictionary *)callBack {

    NSString *name = [callBack objectForKey:@"name"];

    NSString *password = [callBack objectForKey:@"password"];

    self.displayLabel.text = [[NSString alloc] initWithFormat:@"name : %@ \npassword: %@", name, password];
}

- (void) parameters {
    
    [[HiRouter.instance build:@"parameters" fromViewController:self withParameters:@{@"name":@"tom"} action:HiRouterNavigationActionPush] buildAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
