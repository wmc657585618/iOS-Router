//
//  HiDealloc.h
//  RouterDemo
//
//  Created by four on 2020/4/26.
//  Copyright © 2020 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 OBJC_ASSOCIATION_ASSIGN 对象 realse 之后, 再次引用会 crash
 HiDealloc : 当 对象的 OBJC_ASSOCIATION_ASSIGN 引用 realse 之后 会设置为 nil
 */
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HiDealloc)

// 添加 property

- (void)hi_addAssingPropertyForKey:(const void *)key value:(id _Nullable)value;

- (void)hi_addRetainNonatomicPropertyForKey:(const void *)key value:(id _Nullable)value;

- (void)hi_addCopyNonatomicPropertyForKey:(const void *)key value:(id _Nullable)value;

- (void)hi_addRetainPropertyForKey:(const void *)key value:(id _Nullable)value;

- (void)hi_addCopyPropertyForKey:(const void *)key value:(id _Nullable)value;

- (id)hi_getValueForKey:(const void *)key;

@end

NS_ASSUME_NONNULL_END
