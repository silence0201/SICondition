//
//  NSObject+Binder.h
//  SIConditionDemo
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIBinder.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Binder)

- (SIBinder *)binderWithKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
