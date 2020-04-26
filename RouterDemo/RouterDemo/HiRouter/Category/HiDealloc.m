//
//  HiDealloc.m
//  RouterDemo
//
//  Created by four on 2020/4/26.
//  Copyright © 2020 Four. All rights reserved.
//

#import "HiDealloc.h"
#import <objc/runtime.h>

typedef void(^HideallocBlock)(void);
#pragma mark - interface
@interface HiDeallocObserver : NSObject

@property (nonatomic,weak) NSObject *observer;
@property (nonatomic,copy) HideallocBlock block;

@end

@interface NSObject (HiDeallocPrivate)

/**
 当 observer realse 时, observer 会通知当前对象的持有者 将当前对象置为 nil
 */
@property (nonatomic,strong) HiDeallocObserver *deallocObserver;

@end

#pragma mark - implementation
@implementation HiDeallocObserver

- (instancetype)initWithBlock:(HideallocBlock)block
{
    self = [super init];
    if (self) {
        _block = block;
    }
    return self;
}

- (void)dealloc {
    if(self.block) self.block();
}

@end

@implementation NSObject (hi_delegate)

- (void)setDeallocObserver:(HiDeallocObserver *)deallocObserver {
    objc_setAssociatedObject(self, @selector(deallocObserver), deallocObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HiDeallocObserver *)deallocObserver {
    return objc_getAssociatedObject(self, @selector(deallocObserver));
}


- (void)hi_addObserverWithBlock:(HideallocBlock)block{
    self.deallocObserver = [[HiDeallocObserver alloc] initWithBlock:block];
}

- (void)hi_addPropertyForKey:(const void *)key value:(id)value policy:(objc_AssociationPolicy)policy {
    
    if ([value isKindOfClass:NSObject.class]) {
        NSObject *object = value;
        __weak typeof(self) weak = self;
        [object hi_addObserverWithBlock:^{
            __strong typeof(weak) strong = weak;
            [strong hi_addPropertyForKey:key value:nil policy:policy];
        }];
    }
    objc_setAssociatedObject(self, key, value, policy);
}

#pragma mark - public
- (void)hi_addAssingPropertyForKey:(const void *)key value:(id _Nullable)value {
    [self hi_addPropertyForKey:key value:value policy:OBJC_ASSOCIATION_ASSIGN];
}

- (void)hi_addRetainNonatomicPropertyForKey:(const void *)key value:(id _Nullable)value {
    [self hi_addPropertyForKey:key value:value policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (void)hi_addCopyNonatomicPropertyForKey:(const void *)key value:(id _Nullable)value {
    [self hi_addPropertyForKey:key value:value policy:OBJC_ASSOCIATION_COPY_NONATOMIC];
}

- (void)hi_addRetainPropertyForKey:(const void *)key value:(id _Nullable)value {
    [self hi_addPropertyForKey:key value:value policy:OBJC_ASSOCIATION_RETAIN];
}

- (void)hi_addCopyPropertyForKey:(const void *)key value:(id _Nullable)value {
    [self hi_addPropertyForKey:key value:value policy:OBJC_ASSOCIATION_COPY];
}

- (id)hi_getValueForKey:(const void *)key {
    return objc_getAssociatedObject(self, key);
}

@end
