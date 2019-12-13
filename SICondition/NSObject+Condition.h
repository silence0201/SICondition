//
//  NSObject+Condition.h
//  SIConditionDemo
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SICondition.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Condition)

- (void)registerCondition:(SICondition *)condition callBack:(ConditionCallBack)callback;

@end

NS_ASSUME_NONNULL_END
