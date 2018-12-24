//
//  HiRootTableModel.h
//  RouterDemo
//
//  Created by four on 2018/12/24.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HiRootTableModelTypeNetwork,
    HiRootTableModelTypePage,
    HiRootTableModelTypeCallBack,
    HiRootTableModelTypeParametes,
} HiRootTableModelType;
NS_ASSUME_NONNULL_BEGIN

@interface HiRootTableModel : NSObject
@property (nonatomic,assign) HiRootTableModelType type;
@property (nonatomic,copy) NSString *title;

- (instancetype)initWithTitle:(NSString *)title type:(HiRootTableModelType)type;

@end

NS_ASSUME_NONNULL_END
