//
//  HiRouterVMImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"
#import "NSObjectHiExtension.h"

@interface NSObject (hi_delegate)<HiRouterViewModel>

@property (nonatomic,weak) NSObject<HiRouterViewModel> * hi_private_delegate;

@end

@implementation NSObject (hi_delegate)

- (void)setHi_private_delegate:(NSObject<HiRouterViewModel> *)hi_private_delegate {
    [self hi_addAssingPropertyForKey:@selector(hi_private_delegate) value:hi_private_delegate];
}

- (NSObject<HiRouterViewModel> *)hi_private_delegate {
    return [self hi_getValueForKey:@selector(hi_private_delegate)];
}

@end

@implementation HiRouter (VM)

+ (void) bind:(NSObject<HiRouterViewModel> *)objcA objcB:(NSObject<HiRouterViewModel> *)objcB {
    
    objcA.hi_private_delegate = objcB;
    objcB.hi_private_delegate = objcA;
}

+(BOOL)objc:(NSObject<HiRouterViewModel> *)objc postData:(id)data {
    
    if ([objc.hi_private_delegate respondsToSelector:@selector(received:)]) {
        
        [objc.hi_private_delegate received:data];

        return true;
    }

    return false;
}

#pragma mark - public
/**
 build view and model in dynamic
 */

- (void) buildViewModelInDynamic:(NSObject<HiRouterViewModel> *)objectA objectB:(NSObject<HiRouterViewModel> *)objectB {
    
    [HiRouter bind:objectA objcB:objectB];
}

- (BOOL) invork:(NSObject<HiRouterViewModel> *)invork postData:(id)data {

    return [HiRouter objc:invork postData:data];
}

@end
