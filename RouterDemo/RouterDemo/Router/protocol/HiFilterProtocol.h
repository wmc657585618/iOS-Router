//
//  HiFilterProtocol.h
//  RouterDemo
//
//  Created by four on 2018/11/6.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HiFilterProtocol <NSObject>

@property (nonatomic,readonly) NSString *originPath;
@property (nonatomic,readonly) NSString *forwardPath;
@property (nonatomic,readonly) id defaultParameters;

@end
