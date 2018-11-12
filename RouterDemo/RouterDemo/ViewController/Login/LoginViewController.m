//
//  LoginViewController.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "LoginViewController.h"

#import "HiRouter_h.h"

@interface LoginViewController ()<HiRouterPageProtocol>

@property (copy, nonatomic) HiRouterCallBack callBack;

@property (strong, nonatomic) UITextField *userNameTextField;

@property (strong, nonatomic) UITextField *passwordTextField;

@end

@implementation LoginViewController

- (UITextField *)userNameTextField {
    
    if (!_userNameTextField) {
        
        _userNameTextField = [[UITextField alloc] init];
        
        _userNameTextField.placeholder = @"user name";
        
        _userNameTextField.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1];
    }
    
    return _userNameTextField;
}

- (UITextField *)passwordTextField {
    
    if (!_passwordTextField) {
        
        _passwordTextField = [[UITextField alloc] init];
        
        _passwordTextField.placeholder = @"password";
        
        _passwordTextField.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1];
    }
    
    return _passwordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:46 / 255.0 green:139 / 255.0 blue:87 / 255.0 alpha:1];
    
    CGFloat width = self.view.bounds.size.width - 20;
    
    
    self.userNameTextField.frame = CGRectMake(10, 100, width, 44);
    
    [self.view addSubview:self.userNameTextField];
    
    
    self.passwordTextField.frame = CGRectMake(10, CGRectGetMaxY(self.userNameTextField.frame) + 10, width, 44);
    
    [self.view addSubview:self.passwordTextField];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    button.frame = CGRectMake(10, CGRectGetMaxY(self.passwordTextField.frame) + 10, width, 44);
    
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
//    self.callBack = [HiRouter.instance callBackForViewController:self];
}

- (void) dismiss {
    
    [self.view endEditing:true];
    
    NSString *name = self.userNameTextField.text;
    
    NSString *password = self.passwordTextField.text;
    
    [HiRouter.instance routerCallBackFromViewController:self callBackParameters:@{@"name":name,@"password":password}];
    
    [self dismissViewControllerAnimated:true completion:nil];
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
