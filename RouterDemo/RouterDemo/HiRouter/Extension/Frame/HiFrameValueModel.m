//
//  HiFrameValueModel.m
//  RouterDemo
//
//  Created by four on 2020/5/22.
//  Copyright © 2020 Four. All rights reserved.
//

#import "HiFrameValueModel.h"

@interface HiFrameValueModel ()

@property (nonatomic,strong) NSNumber * l;
@property (nonatomic,strong) NSNumber * r;
@property (nonatomic,strong) NSNumber * t;
@property (nonatomic,strong) NSNumber * b;
@property (nonatomic,strong) NSNumber * w;
@property (nonatomic,strong) NSNumber * h;
@property (nonatomic,strong) NSNumber * cx;
@property (nonatomic,strong) NSNumber * cy;

@end

@implementation HiFrameValueModel

- (void)setHi_l:(CGFloat)hi_l {
    self.l = @(hi_l);
}

- (CGFloat)hi_l {
   
    // 当前 有就用 没有看组合
    if (self.l) return self.l.doubleValue;
    
    if (self.r && self.w) return self.r.doubleValue - self.w.doubleValue;
    if (self.cx && self.w) return self.cx.doubleValue - self.w.doubleValue * 0.5;
    if (self.cx && self.r) return self.cx.doubleValue - (self.r.doubleValue - self.cx.doubleValue);
    
    return self.frame.origin.x;
}

- (void)setHi_r:(CGFloat)hi_r {
    self.r = @(hi_r);
}

- (CGFloat)hi_r {
    
    // 当前 有就用 没有看组合
    if (self.r) return self.r.doubleValue;

    if (self.l && self.w) return self.l.doubleValue + self.w.doubleValue;
    if (self.cx && self.l) return self.cx.doubleValue + (self.cx.doubleValue - self.l.doubleValue);
    if (self.cx && self.w) return self.cx.doubleValue + self.w.doubleValue * 0.5;

     return self.frame.origin.x + self.frame.size.width;
}

- (void)setHi_t:(CGFloat)hi_t {
    self.t = @(hi_t);
}

- (CGFloat)hi_t {
    
    // 当前 有就用 没有看组合
    if (self.t) return self.t.doubleValue;
    
    if (self.b && self.h) return self.b.doubleValue - self.h.doubleValue;
    
    if (self.cy && self.h) return self.cy.doubleValue - self.h.doubleValue * 0.5;
    if (self.cy && self.b) return self.cy.doubleValue - (self.b.doubleValue - self.cy.doubleValue);

    return self.frame.origin.y;
}

- (void)setHi_b:(CGFloat)hi_b {
    self.b = @(hi_b);
}

- (CGFloat)hi_b {
    
    // 当前 有就用 没有看组合
    if (self.b) return self.b.doubleValue;
    
    if (self.t && self.h) return self.t.doubleValue + self.h.doubleValue;
    if (self.cy && self.h) return self.cy.doubleValue + self.h.doubleValue * 0.5;
    if (self.cy && self.t) return self.cy.doubleValue + (self.cy.doubleValue - self.t.doubleValue);

    return self.frame.origin.y + self.frame.size.height;
}

- (void)setHi_h:(CGFloat)hi_h {
    self.h = @(hi_h);
}

- (CGFloat)hi_h {
    
    // 当前 有就用 没有看组合
    if (self.h) return self.h.doubleValue;
    
    if (self.t && self.b) return self.b.doubleValue - self.t.doubleValue;
    if (self.cy && self.t) return (self.cy.doubleValue - self.t.doubleValue) * 2;
    if (self.cy && self.b) return (self.b.doubleValue - self.cy.doubleValue) * 2;

    return self.frame.size.height;
}

- (void)setHi_w:(CGFloat)hi_w {
    self.w = @(hi_w);
}

- (CGFloat)hi_w {
    
    // 当前 有就用 没有看组合
    if (self.w) return self.w.doubleValue;
    if (self.l && self.r) return self.r.doubleValue - self.l.doubleValue;
    if (self.cx && self.r) return (self.r.doubleValue - self.cx.doubleValue) * 2;
    if (self.cx && self.l) return (self.cx.doubleValue - self.l.doubleValue) * 2;

    return self.frame.size.height;
}

- (void)setHi_cx:(CGFloat)hi_cx {
    self.cx = @(hi_cx);
}

- (CGFloat)hi_cx {
    
    // 当前 有就用 没有看组合
    if (self.cx) return self.cx.doubleValue;
    if (self.l && self.w) return self.l.doubleValue + self.w.doubleValue * 0.5;
    if (self.r && self.w) return self.r.doubleValue - self.w.doubleValue * 0.5;
    
    if (self.l && self.r) return (self.r.doubleValue - self.l.doubleValue) * 0.5 + self.r.doubleValue;

    
    return self.frame.size.width * 0.5 + self.frame.origin.x;
}

- (void)setHi_cy:(CGFloat)hi_cy {
    self.cy = @(hi_cy);
}

- (CGFloat)hi_cy {
    
    // 当前 有就用 没有看组合
    if (self.cy) return self.cy.doubleValue;
    
    if (self.t && self.h) return self.t.doubleValue + self.h.doubleValue * 0.5;
    if (self.b && self.h) return self.b.doubleValue - self.h.doubleValue * 0.5;

    if (self.t && self.b) return (self.b.doubleValue - self.t.doubleValue) * 0.5 + self.t.doubleValue;
    
    return self.frame.origin.y + self.frame.size.height * 0.5;
}

- (CGRect)hi_frame {
    return CGRectMake(self.hi_l, self.hi_t, self.hi_w, self.hi_h);
}

- (void)updateFrameValue:(CGFloat)value forAttribute:(NSLayoutAttribute)attribute {

    switch (attribute) {
        case NSLayoutAttributeLeft:
        case NSLayoutAttributeLeading:
            self.hi_l = value;
            break;

        case NSLayoutAttributeRight:
        case NSLayoutAttributeTrailing:
            self.hi_r = value;
            break;
            
        case NSLayoutAttributeTop:
            self.hi_t = value;
            break;

        case NSLayoutAttributeBottom:
            self.hi_b = value;
            break;

        case NSLayoutAttributeWidth:
            self.hi_w = value;
            break;

        case NSLayoutAttributeHeight:
            self.hi_h = value;
            break;

        case NSLayoutAttributeCenterX:
            self.hi_cx = value;
            break;
            
        case NSLayoutAttributeCenterY:
            self.hi_cy = value;
            break;

        default:
            break;
    }
}

- (CGFloat)valueForAttribute:(NSLayoutAttribute)attribute{
    
    switch (attribute) {
        case NSLayoutAttributeLeft:
        case NSLayoutAttributeLeading:
            return self.hi_l;

        case NSLayoutAttributeRight:
        case NSLayoutAttributeTrailing:
            return self.hi_r;
            break;
            
        case NSLayoutAttributeTop:
            return self.hi_t;
            break;

        case NSLayoutAttributeBottom:
            return self.hi_b;
            break;

        case NSLayoutAttributeWidth:
            return self.hi_w;
            break;

        case NSLayoutAttributeHeight:
            return self.hi_h;
            break;

        case NSLayoutAttributeCenterX:
            return self.hi_cx;
            break;
            
        case NSLayoutAttributeCenterY:
            return self.hi_cy;
            break;

        default:
            return 0;
    }
}

@end
