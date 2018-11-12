//
//  HiPathFilter.h
//  RouterDemo
//
//  Created by four on 2018/11/6.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HiPathFilter : NSObject

/**
 page scheme default is "Hipage"
 */
@property (nonatomic,copy) NSString *pagePre;

- (void)pathFilterWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
