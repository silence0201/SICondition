//
//  NSObject+Condition.m
//  SIConditionDemo
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "NSObject+Condition.h"
#import <objc/runtime.h>

@implementation NSObject (Condition)

- (void)registerCondition:(SICondition *)condition callBack:(ConditionCallBack)callback {
    if (condition == nil) return;
    [[self _conditionsDic] setObject:condition forKey:condition.name];
    condition.callBack = callback;
    condition.target = self;
}

- (NSMutableDictionary *)_conditionsDic {
    NSMutableDictionary *bindersDic = objc_getAssociatedObject(self, _cmd);
    if (bindersDic) {
        bindersDic = [NSMutableDictionary dictionary];
        [self _setConditionsDic:bindersDic];
    }
    return bindersDic;
}

- (void)_setConditionsDic:(NSMutableDictionary *)binderDic {
    objc_setAssociatedObject(self, @selector(_conditionsDic), binderDic, OBJC_ASSOCIATION_RETAIN);
}

@end
