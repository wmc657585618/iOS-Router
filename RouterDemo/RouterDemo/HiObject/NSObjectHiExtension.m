//
//  NSObjectHiExtension.m
//  RouterDemo
//
//  Created by four on 2020/5/12.
//  Copyright © 2020 Four. All rights reserved.
//

#import "NSObjectHiExtension.h"
#import "HiDealloc.h"

@interface NSObject ()

@property (nonatomic,strong,readonly) NSMutableDictionary<NSString *,NSHashTable *> *keyObserverMap;

@end

@implementation NSObject (HiObserver)

- (NSMutableDictionary *)keyObserverMap {
    
    NSMutableDictionary *map = [self hi_getValueForKey:@selector(keyObserverMap)];
    if (!map) {
        map = [NSMutableDictionary dictionary];
        [self hi_addRetainPropertyForKey: @selector(keyObserverMap) value:map];
    }
    return map;
}

#pragma mark - private
- (void)addObject:(NSObject *)object forKeyPath:(NSString *)keyPath{
    
    NSHashTable *table = [self.keyObserverMap objectForKey:keyPath];
    if (!table) {
        table = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
        [self.keyObserverMap setObject:table forKey:keyPath];
    }
    
    if (![table containsObject:object]) {
        [table addObject:object];
    }
}

- (void)removeObject:(NSObject *)object forKeyPath:(NSString *)keyPath {
    NSHashTable *table = [self.keyObserverMap objectForKey:keyPath];
    [table removeObject:object];
}

- (BOOL)containsObject:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSHashTable *table = [self.keyObserverMap objectForKey:keyPath];
    return [table containsObject:observer];
}

#pragma mark - public
- (void)hi_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
 {
    if (observer && keyPath) {
        [self addObject:observer forKeyPath:keyPath];
        [self addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)hi_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
   
    if (observer && keyPath) {
        if ([self containsObject:observer forKeyPath:keyPath]){
            [self removeObserver:observer forKeyPath:keyPath];
            [self removeObject:observer forKeyPath:keyPath];
        }
    }
}

- (void)hi_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    
    if (observer && keyPath) {
        if ([self containsObject:observer forKeyPath:keyPath]){
            [self removeObserver:observer forKeyPath:keyPath context:context];
            [self removeObject:observer forKeyPath:keyPath];
        }
    }
}

- (void)hi_removeAllObserverForKeyPath:(NSString *)keyPath {
    if (keyPath) {
        NSHashTable *table = [self.keyObserverMap objectForKey:keyPath];
        for (NSObject *observer in table.allObjects) {
            [self removeObserver:observer forKeyPath:keyPath];
        }
        [table removeAllObjects];
    }
}

- (void)hi_removeAllObservers {
    NSArray *keyArray = self.keyObserverMap.allKeys;
    for (NSString *key in keyArray) {
        [self hi_removeAllObserverForKeyPath:key];
    }
}

@end


#pragma mark - dictionary
@implementation NSDictionary (HiCategory)

- (HiObjectStruct)hi_objectForkey:(NSString *)key class:(Class)class{
    
    id objc = [self hi_valueForKey:key];
    HiObjectStruct dictionary;
    dictionary.objc = objc;
    dictionary.result = [objc isKindOfClass:class];
    return dictionary;
}

- (nullable id)hi_valueForKey:(NSString *)defaultName {
    if (defaultName) return [self valueForKey:defaultName];
    return nil;
}

- (nullable id)hi_objectForKey:(NSString *)defaultName {
    return [self hi_valueForKey:defaultName];
}

- (void)hi_removeObjectForKey:(NSString *)defaultName {
    if (defaultName) {
        [self setValue:nil forKey:defaultName];
    }
}

- (nullable NSString *)hi_stringForKey:(NSString *)defaultName {
    
    HiObjectStruct dictionaryStruce = [self hi_objectForkey:defaultName class:NSString.class];
    
    if (dictionaryStruce.result) return dictionaryStruce.objc;
    if ([dictionaryStruce.objc respondsToSelector:@selector(stringValue)]){ // number 可以转 string
        return [dictionaryStruce.objc stringValue];
    }
    
    return nil;
}

- (nullable NSArray *)hi_arrayForKey:(NSString *)defaultName {
    
    HiObjectStruct dictionaryStruce = [self hi_objectForkey:defaultName class:NSArray.class];
    if (dictionaryStruce.result) return dictionaryStruce.objc;
    
    return nil;
}

- (nullable NSDictionary<NSString *, id> *)hi_dictionaryForKey:(NSString *)defaultName {
    
    HiObjectStruct dictionaryStruce = [self hi_objectForkey:defaultName class:NSDictionary.class];
    if (dictionaryStruce.result) return dictionaryStruce.objc;
    
    return nil;
}

- (nullable NSString *)hi_numberForKey:(NSString *)defaultName {
    
    HiObjectStruct dictionaryStruce = [self hi_objectForkey:defaultName class:NSDictionary.class];
    if (dictionaryStruce.result) return dictionaryStruce.objc;
    return nil;
}

- (NSInteger)hi_integerForKey:(NSString *)defaultName {
    NSString *string = [self hi_stringForKey:defaultName];
    return [string integerValue];
}

- (float)hi_floatForKey:(NSString *)defaultName {
    NSString *string = [self hi_stringForKey:defaultName];
    return [string floatValue];
}

- (double)hi_doubleForKey:(NSString *)defaultName {
    NSString *string = [self hi_stringForKey:defaultName];
    return [string doubleValue];
}

- (BOOL)hi_boolForKey:(NSString *)defaultName {
    NSString *string = [self hi_stringForKey:defaultName];
    return [string boolValue];
}

@end

@implementation NSMutableDictionary (HiCategory)

- (void)hi_removeObjectForKey:(NSString *)defaultName {
    if (defaultName) [self removeObjectForKey:defaultName];
}

- (void)hi_setObject:(id)value forKey:(NSString *)defaultName {
    if (value && defaultName) [self setValue:value forKey:defaultName];
}

- (void)hi_setInteger:(NSInteger)value forKey:(NSString *)defaultName {
    if (defaultName) [self setValue:@(value) forKey:defaultName];
}

- (void)hi_setFloat:(float)value forKey:(NSString *)defaultName {
    if (defaultName) [self setValue:@(value) forKey:defaultName];
}

- (void)hi_setDouble:(double)value forKey:(NSString *)defaultName {
    if (defaultName) [self setValue:@(value) forKey:defaultName];
}

- (void)hi_setBool:(BOOL)value forKey:(NSString *)defaultName {
    if (defaultName) [self setValue:@(value) forKey:defaultName];
}

@end

@implementation NSArray (HiCategory)

- (HiObjectStruct)hi_objectAtIndex:(NSUInteger)index class:(Class)class {
    HiObjectStruct arrayStruct;

    if (index < self.count) {
        
        id objc = [self objectAtIndex:index];
        arrayStruct.objc = objc;
        arrayStruct.result = [objc isKindOfClass:class];
        return arrayStruct;
    }
    arrayStruct.objc = nil;
    arrayStruct.result = false;
    return arrayStruct;
}

- (nullable id)hi_objectAtIndex:(NSUInteger)index {
    if (index < self.count) return [self objectAtIndex:index];
    return nil;
}

- (nullable NSString *)hi_stringAtIndex:(NSUInteger)index {
    HiObjectStruct arrayStruct = [self hi_objectAtIndex:index class:NSString.class];
     
    if (arrayStruct.result) return arrayStruct.objc;
    if ([arrayStruct.objc respondsToSelector:@selector(stringValue)]){ // number 可以转 string
       return [arrayStruct.objc stringValue];
    }
    
    return nil;
}

- (nullable NSString *)hi_numberAtIndex:(NSUInteger)index {
    HiObjectStruct arrayStruct = [self hi_objectAtIndex:index class:NSNumber.class];
     
    if (arrayStruct.result) return arrayStruct.objc;
    return nil;
}

- (nullable NSArray *)hi_arrayAtIndex:(NSUInteger)index {
    HiObjectStruct arrayStruct = [self hi_objectAtIndex:index class:NSArray.class];
     
    if (arrayStruct.result) return arrayStruct.objc;
    return nil;
}

- (nullable NSDictionary *)hi_dictionaryAtIndex:(NSUInteger)index {
    HiObjectStruct arrayStruct = [self hi_objectAtIndex:index class:NSDictionary.class];
     
    if (arrayStruct.result) return arrayStruct.objc;
    return nil;
}


- (NSInteger)hi_integerAtIndex:(NSUInteger)index {
    NSString *string = [self hi_stringAtIndex:index];
    return string.integerValue;
}

- (float)hi_floatAtIndex:(NSUInteger)index {
    NSString *string = [self hi_stringAtIndex:index];
    return string.floatValue;
}

- (double)hi_doubleAtIndex:(NSUInteger)index {
    NSString *string = [self hi_stringAtIndex:index];
    return string.doubleValue;
}

- (BOOL)hi_boolAtIndex:(NSUInteger)index  {
    NSString *string = [self hi_stringAtIndex:index];
    return string.boolValue;
}

// 去除 上限
- (NSRange)availableRange:(NSRange)range {
    NSUInteger location = range.location;
    NSUInteger length = location + range.length;
    if (length > self.count) {
        length = self.count - location;
        if (length < 0) length = 0;
    }
    
    if (location < 0) location = 0;
    return NSMakeRange(location, length);
}

@end

@implementation NSMutableArray (HiCategory)

- (void)hi_addObject:(id)anObject {
    if (anObject) [self addObject:anObject];
}

- (void)hi_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
}

- (void)hi_removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

- (void)hi_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject && index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)hi_addObjectsFromArray:(NSArray *)otherArray {
    for (id objc in otherArray) {
        [self hi_addObject:objc];
    }
}

- (void)hi_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    
    NSUInteger count = self.count;
    if (idx1 < count && idx2 < count) {
        [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
}

- (void)hi_removeObject:(id)anObject inRange:(NSRange)range {
    if (!anObject) return;
    
    NSRange availableRange = [self availableRange:range];
    NSUInteger min = availableRange.location;
    if (min < self.count) [self removeObject:anObject inRange:range];
}

- (void)hi_removeObject:(id)anObject {
    if (anObject) [self removeObject:anObject];
}



- (void)hi_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    if (!anObject) return;
    
    NSRange availableRange = [self availableRange:range];
    NSUInteger min = availableRange.location;
    if (min < self.count) [self removeObjectIdenticalTo:anObject inRange:availableRange];
}

- (void)hi_removeObjectIdenticalTo:(id)anObject {
    if (anObject) [self removeObjectIdenticalTo:anObject];
}

- (void)hi_removeObjectsInArray:(NSArray *)otherArray {
    
    for (id object in otherArray) {
        [self hi_removeObject:object];
    }
}

- (void)hi_removeObjectsInRange:(NSRange)range {
    
    NSRange availableRange = [self availableRange:range];
    NSUInteger min = availableRange.location;
    if (min < self.count) [self removeObjectsInRange:availableRange];
}

- (void)hi_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange {
    if (!otherArray) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:otherArray.count];
    [array hi_addObjectsFromArray:otherArray];
    
    NSRange availableRange1 = [self availableRange:range];
    NSUInteger min1 = availableRange1.location;
    
    NSRange availableRange2 = [array availableRange:otherRange];
    NSUInteger min2 = availableRange2.location;
    
    if (min1 < self.count && min2 < array.count) {
        [self replaceObjectsInRange:availableRange1 withObjectsFromArray:array range:availableRange2];
    }
}

- (void)hi_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    
    if (!otherArray) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:otherArray.count];
    [array hi_addObjectsFromArray:otherArray];
    
    NSRange availableRange = [self availableRange:range];
    NSUInteger min = availableRange.location;
    if (min < self.count) {
        [self replaceObjectsInRange:range withObjectsFromArray:array];
    }
}

@end
