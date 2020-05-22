//
//  HiOptions.m
//  RouterDemo
//
//  Created by four on 2020/5/22.
//  Copyright © 2020 Four. All rights reserved.
//

#import "HiOptions.h"

@implementation HiOptions

/**
    x-y-r-b : 15
    x-y-b-w : 29
    r-y-b-w : 30
    x-r-y-h : 39
    x-r-b-h : 43
    x-y-w-h : 53
    r-y-w-h : 54
    x-b-w-h : 57
    r-b-w-h : 58
    cx-y-b-w : 92
    cx-y-w-h : 116
    cx-b-w-h : 120
    x-r-cy-h : 163
    x-cy-w-h : 177
    r-cy-w-h : 178
    cx-cy-w-h : 240
*/

#if DEBUG

+ (NSString *)stringForOptions:(HiViewOptions)options{

    NSMutableString *string = [NSMutableString stringWithString:@"- "];
    if (HiViewOptionsLeft & options) [string appendFormat:@"L - "];
    
    if (HiViewOptionsRight & options) [string appendFormat:@"R - "];
    
    if (HiViewOptionsTop & options) [string appendFormat:@"T - "];
    
    if (HiViewOptionsBottom & options) [string appendFormat:@"B - "];
    
    if (HiViewOptionsCenterX & options) [string appendFormat:@"CX - "];
    
    if (HiViewOptionsCenterY & options) [string appendFormat:@"CY - "];
    
    if (HiViewOptionsWidth & options) [string appendFormat:@"W - "];
    
    if (HiViewOptionsHeight & options) [string appendFormat:@"l - "];

    return string;
}

#endif

+ (BOOL)availableViewOptions:(HiViewOptions)options{
    
    switch (options) {
        case 53:
        case 57:
        case 177:
        case 54:
        case 58:
        case 178:
        case 116:
        case 120:
        case 240:
        case 39:
        case 43:
        case 163:
        case 29:
        case 30:
        case 92:
        case 15:
            return true;
            
        default:
#ifdef DEBUG
            NSLog(@"👉👉👉 组合:%@是不合格的, 请检查",[self stringForOptions:options]);
#endif
            return false;
    }
}

+ (HiViewOptions)viewOptions:(HiViewOptions)options forAttribute:(NSLayoutAttribute)attribute{
    
    HiViewOptions option = HiViewOptionsNone;
    
    switch (attribute) {
        case NSLayoutAttributeLeft:
            option = HiViewOptionsLeft;
            
            break;
        case NSLayoutAttributeRight:
            option = HiViewOptionsRight;
            
            break;
        case NSLayoutAttributeTop:
            option = HiViewOptionsTop;

            break;
        case NSLayoutAttributeBottom:
            option = HiViewOptionsBottom;

            break;
        case NSLayoutAttributeLeading:
            option = HiViewOptionsLeft;

            break;
        case NSLayoutAttributeTrailing:
            option = HiViewOptionsRight;

            break;
        case NSLayoutAttributeWidth:
            option = HiViewOptionsWidth;

            break;
        case NSLayoutAttributeHeight:
            option = HiViewOptionsHeight;

            break;
        case NSLayoutAttributeCenterX:
            option = HiViewOptionsCenterX;

            break;
        case NSLayoutAttributeCenterY:
            option = HiViewOptionsCenterY;

            break;
        default:
            break;
    }
    
    if (HiViewOptionsNone == option) return options;
    
    // 原来是 空
    if(HiViewOptionsNone == options) return option;
    
    if (option & options) return options; // 已经有了
    
    return options | option;
}

@end
