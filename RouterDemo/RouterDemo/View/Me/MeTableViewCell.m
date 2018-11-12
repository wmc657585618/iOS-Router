//
//  MeTableViewCell.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "MeTableViewCell.h"

@interface MeTableViewCell ()

@property (strong, nonatomic) UIButton *submitButton;

@property (strong, nonatomic) UITextField *userNameTextField;

@property (strong, nonatomic) UITextField *passwordTextField;

@end

@implementation MeTableViewCell

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

- (UIButton *)submitButton {
    
    if (!_submitButton) {
        
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _submitButton.backgroundColor = [UIColor colorWithRed:139 / 255.0 green:69 / 255.0 blue:19 / 255.0 alpha:1];
    }
    
    return _submitButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.userNameTextField];
        
        [self.contentView addSubview:self.passwordTextField];
        
        [self.contentView addSubview:self.submitButton];
        
        [self.submitButton addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    CGFloat width = self.contentView.frame.size.width - 70;
    
    self.userNameTextField.frame = CGRectMake(10, 10, width, 40);
    
    self.passwordTextField.frame = CGRectMake(10, CGRectGetMaxY(self.userNameTextField.frame) + 10, width, 40);

    self.submitButton.frame = CGRectMake(CGRectGetMaxX(self.passwordTextField.frame) + 10, 10, 40, 40);
}

- (void)received:(NSDictionary *)receive {
    
    self.userNameTextField.text = [receive objectForKey:@"name"];
    
    self.passwordTextField.text = [receive objectForKey:@"password"];
}

- (void) doAction {
    
    NSString *name = self.userNameTextField.text;
    
    NSString *password = self.passwordTextField.text;
    
    [HiRouter.instance invork:self postData:@{@"name":name,@"password":password}];
}

@end
