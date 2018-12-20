//
//  HiFilterProtocol.h
//  RouterDemo
//
//  Created by four on 2018/11/6.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterDefine.h"

@protocol HiFilterProtocol <NSObject>

// like path/path1/path2/path3 , path/path1, path/path1/path2, path/path1/path2/path3 ....
// if you want to filt all,like this paht*, then path1 and path2 will be filt, * all
@property (nonatomic,readonly) NSString *filtPath;
@property (nonatomic,copy) NSString *originPath;
@property (nonatomic,readonly) NSString *forwardPath;
@property (nonatomic,readonly) id defaultParameters;

@end

@protocol HiPageFilterProtocol <HiFilterProtocol>

@property (nonatomic,readonly) HiRouterNavigationAction navigationAction;

@end

@protocol HiNetworkFilterProtocol <HiFilterProtocol>

@property (nonatomic,readonly) NSString *result;

@end
