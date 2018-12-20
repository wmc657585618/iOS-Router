//
//  HiNetworkEntity.h
//  RouterDemo
//
//  Created by four on 2018/12/19.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 
 @property (nullable, readonly, copy) NSString *absoluteString;
 @property (readonly, copy) NSString *relativeString; // The relative portion of a URL.  If baseURL is nil, or if the receiver is itself absolute, this is the same as absoluteString
 @property (nullable, readonly, copy) NSURL *baseURL; // may be nil.
 @property (nullable, readonly, copy) NSURL *absoluteURL; // if the receiver is itself absolute, this will return self.
 

@property (nullable, readonly, copy) NSString *scheme;
@property (nullable, readonly, copy) NSString *resourceSpecifier;

@property (nullable, readonly, copy) NSString *host;
@property (nullable, readonly, copy) NSNumber *port;
@property (nullable, readonly, copy) NSString *user;
@property (nullable, readonly, copy) NSString *password;
@property (nullable, readonly, copy) NSString *path;
@property (nullable, readonly, copy) NSString *fragment;
@property (nullable, readonly, copy) NSString *parameterString;
@property (nullable, readonly, copy) NSString *query;
@property (nullable, readonly, copy) NSString *relativePath; // The same as path if baseURL is nil


 */
NS_ASSUME_NONNULL_BEGIN

@interface HiNetworkEntity : NSObject
@property (nonatomic,strong) NSURL *url;

@end

NS_ASSUME_NONNULL_END
