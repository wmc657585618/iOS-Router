//
//  NSString+HiPredicate.h
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HiPredicate)

-(BOOL)isValidateRegularByExpression:(NSString *)strExpression;

@end

NS_ASSUME_NONNULL_END
