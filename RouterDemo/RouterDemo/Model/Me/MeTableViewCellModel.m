//
//  MeTableViewCellModel.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "MeTableViewCellModel.h"

@interface MeTableViewCellModel ()

@end

@implementation MeTableViewCellModel

- (void)received:(NSDictionary *)receive {
    
    self.name = [receive objectForKey:@"name"];
    
    self.password = [receive objectForKey:@"password"];
}

- (void) doAction {
    
    NSString *name = self.name.length > 0 ? self.name : @"";
    
    NSString *password = self.password.length > 0 ? self.password : @"";
    
    [HiRouter.instance invork:self postData:@{@"name":name,@"password":password}];
}

@end
