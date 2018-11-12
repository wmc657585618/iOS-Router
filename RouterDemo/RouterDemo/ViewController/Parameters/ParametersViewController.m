//
//  ParametersViewController.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "ParametersViewController.h"

#import "HiRouter_h.h"

@interface ParametersViewController ()<HiRouterPageProtocol>

@property (strong, nonatomic) UILabel *displayLabel;

@end

@implementation ParametersViewController

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
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    self.displayLabel.frame = CGRectMake(10, 100, self.view.bounds.size.width - 20, 100);
    
    [self.view addSubview:self.displayLabel];
}

- (void)recivedParameters:(NSDictionary *)parameters {
 
     self.displayLabel.text = parameters.description;
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
