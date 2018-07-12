//
//  MeTableViewCellModel.m
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "MeTableViewCellModel.h"

@interface MeTableViewCellModel ()

@property (copy, nonatomic) RouterCommond commond;

@end

@implementation MeTableViewCellModel

- (void)invorkerCommond:(RouterCommond)invorkerCommond {
    
    self.commond = invorkerCommond;
}

- (void)received:(NSDictionary *)receive {
    
    self.name = [receive objectForKey:@"name"];
    
    self.password = [receive objectForKey:@"password"];
}

- (void) doAction {
    
    if (self.commond) {
        
        NSString *name = self.name.length > 0 ? self.name : @"";
        
        NSString *password = self.password.length > 0 ? self.password : @"";

        self.commond(@{@"name":name,@"password":password});
    }
}

@end
