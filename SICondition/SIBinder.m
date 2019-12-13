//
//  SIBinder.m
//  SIConditionDemo
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIBinder.h"

@interface SIBinder ()
@property (nonatomic, strong) NSMutableDictionary<NSString *,BinderRule> *binderRules;
@end

@implementation SIBinder

- (void)binderRule:(BinderRule)rule toCondition:(NSString *)condition {
    if (!condition || condition.length == 0) return;
    if (rule) {
        [self.binderRules setObject:rule forKey:condition];
    }
}

- (BinderRule)binderRuleForCondition:(NSString *)condition {
    return [self.binderRules objectForKey:condition];
}

- (NSArray *)getAllConditions {
    return [self.binderRules allKeys];
}

- (NSMutableDictionary<NSString *,BinderRule> *)binderRules {
    if (!_binderRules) {
        _binderRules = [NSMutableDictionary dictionary];
    }
    return _binderRules;
}

@end
