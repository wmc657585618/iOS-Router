//
//  HiPageSub1ViewController.m
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiPageSub1ViewController.h"

@interface HiPageSub1ViewController ()

@end

@implementation_router(page/sub/sub1,HiPageSub1ViewController)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat x = 20;
    CGFloat width = self.view.frame.size.width - x * 2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 100, width, 44)];
    label.text = @"subpage1";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:label];
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
