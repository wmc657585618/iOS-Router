//
//  HiFilterProtocol.h
//  RouterDemo
//
//  Created by four on 2018/11/6.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HiFilterProtocol <NSObject>

@required
- (BOOL)filterWithURL:(NSURL *)url;

@end
