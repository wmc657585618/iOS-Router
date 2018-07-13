//
//  MeTableViewCellModel.h
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HiRouterProtocol.h"

@interface MeTableViewCellModel : NSObject<HiRouterViewModel>

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *password;

- (void) doAction;

@end
