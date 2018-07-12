//
//  RouterVMBuilder.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RouterProtocol.h"

@interface RouterVMBuilder : NSObject

@property (strong, nonatomic) id<RouterViewModel> receiver;

@property (strong, nonatomic) id<RouterViewModel> invorker;

- (void) bind;

@end
