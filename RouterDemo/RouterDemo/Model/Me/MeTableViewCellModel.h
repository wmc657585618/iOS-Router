//
//  MeTableViewCellModel.h
//  RouterDemo
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RouterProtocol.h"

@interface MeTableViewCellModel : NSObject<RouterViewModel>

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *password;

- (void) doAction;

@end
