//
//  NSObjectHiExtension.h
//  RouterDemo
//
//  Created by four on 2020/5/12.
//  Copyright © 2020 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define HiBlock(block,...) if (block) block(__VA_ARGS__);
#define HiObjectBlock(objc,block,...) if (block) {objc = block(__VA_ARGS__);};

@interface NSObject (HiObserver)

- (void)hi_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
- (void)hi_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
- (void)hi_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context;
- (void)hi_removeAllObserverForKeyPath:(NSString *)keyPath;
- (void)hi_removeAllObservers;

@end

typedef struct {
    id objc;
    BOOL result; // 是否是同类型
} HiObjectStruct;

#pragma mark - dictionary
@interface NSDictionary (HiCategory)

- (HiObjectStruct)hi_objectForkey:(NSString *)key class:(Class)class;

- (nullable id)hi_valueForKey:(NSString *)defaultName;

- (nullable id)hi_objectForKey:(NSString *)defaultName;

- (void)hi_removeObjectForKey:(NSString *)defaultName;

- (nullable NSString *)hi_stringForKey:(NSString *)defaultName;

- (nullable NSNumber *)hi_numberForKey:(NSString *)defaultName;

- (nullable NSArray *)hi_arrayForKey:(NSString *)defaultName;

- (nullable NSDictionary *)hi_dictionaryForKey:(NSString *)defaultName;


- (NSInteger)hi_integerForKey:(NSString *)defaultName;

- (float)hi_floatForKey:(NSString *)defaultName;

- (double)hi_doubleForKey:(NSString *)defaultName;

// Skips initial space characters (whitespaceSet), or optional -/+ sign followed by zeroes. Returns YES on encountering one of "Y", "y", "T", "t", or a digit 1-9. It ignores any trailing characters.
- (BOOL)hi_boolForKey:(NSString *)defaultName;

@end

@interface NSMutableDictionary (HiCategory)

- (void)hi_setObject:(nullable id)value forKey:(NSString *)defaultName;

- (void)hi_setInteger:(NSInteger)value forKey:(NSString *)defaultName;

- (void)hi_setFloat:(float)value forKey:(NSString *)defaultName;

- (void)hi_setDouble:(double)value forKey:(NSString *)defaultName;

- (void)hi_setBool:(BOOL)value forKey:(NSString *)defaultName;

@end

#pragma mark - array
@interface NSArray (HiCategory)
- (HiObjectStruct)hi_objectAtIndex:(NSUInteger)index class:(Class)class;

- (nullable id)hi_objectAtIndex:(NSUInteger)index;

- (nullable NSString *)hi_stringAtIndex:(NSUInteger)index;

- (nullable NSNumber *)hi_numberAtIndex:(NSUInteger)index;

- (nullable NSArray *)hi_arrayAtIndex:(NSUInteger)index;

- (nullable NSDictionary *)hi_dictionaryAtIndex:(NSUInteger)index;


- (NSInteger)hi_integerAtIndex:(NSUInteger)index;

- (float)hi_floatAtIndex:(NSUInteger)index;

- (double)hi_doubleAtIndex:(NSUInteger)index;

// Skips initial space characters (whitespaceSet), or optional -/+ sign followed by zeroes. Returns YES on encountering one of "Y", "y", "T", "t", or a digit 1-9. It ignores any trailing characters.
- (BOOL)hi_boolAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (HiCategory)

- (void)hi_addObject:(id)anObject;
- (void)hi_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)hi_removeObjectAtIndex:(NSUInteger)index;
- (void)hi_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)hi_addObjectsFromArray:(NSArray *)otherArray;
- (void)hi_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)hi_removeObject:(id)anObject inRange:(NSRange)range;
- (void)hi_removeObject:(id)anObject;
- (void)hi_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (void)hi_removeObjectIdenticalTo:(id)anObject;
- (void)hi_removeObjectsInArray:(NSArray *)otherArray;
- (void)hi_removeObjectsInRange:(NSRange)range;
- (void)hi_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)hi_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;

@end
NS_ASSUME_NONNULL_END
