//
//  RouterVMBuilder.m
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterVMBuilder.h"

@implementation HiRouterVMBuilder

- (void) bind {
    
    __weak typeof(self) weakSelf = self;
    
    [self.invorker invorkerCommond:^(NSDictionary *commond) {
       
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if ([strongSelf.receiver respondsToSelector:@selector(received:)]) {
            
            [strongSelf.receiver received:commond];
        }
    }];
    
    [self.receiver invorkerCommond:^(NSDictionary *commond) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if ([strongSelf.invorker respondsToSelector:@selector(received:)]) {
            
            [strongSelf.invorker received:commond];
        }
    }];
}

- (void)dealloc
{
    NSLog(@"dealloc %@",self);
}

@end
