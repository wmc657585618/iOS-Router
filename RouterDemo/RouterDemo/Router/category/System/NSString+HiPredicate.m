//
//  NSString+HiPredicate.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "NSString+HiPredicate.h"

@implementation NSString (HiPredicate)

-(BOOL)isValidateRegularByExpression:(NSString *)strExpression {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    
    return [predicate evaluateWithObject:self];
    
}

@end
