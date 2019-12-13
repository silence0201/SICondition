//
//  NSObject+Binder.m
//  SIConditionDemo
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "NSObject+Binder.h"
#import "KVOController.h"
#import <objc/runtime.h>

@implementation NSObject (Binder)

- (SIBinder *)binderWithKeyPath:(NSString *)keyPath {
    SIBinder *binder = [[self _bindersDic] objectForKey:keyPath];
    if (binder) {
        unsigned int outCount;
        objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
        BOOL hasProperty = NO;
        for (int i = 0 ; i < outCount; i++) {
            objc_property_t property = propertyList[i];
            const char *property_name = property_getName(property);
            NSString *propertyName = [NSString stringWithCString:property_name encoding:NSUTF8StringEncoding];
            if ([propertyName isEqualToString:keyPath]) {
                hasProperty = YES;
                break;
            }
        }
        
        if (hasProperty) {
            binder = [[SIBinder alloc]init];
            binder.target = self;
            [[self _bindersDic] setObject:binder forKey:keyPath];
            [[self KVOController] observe:self keyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld  block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
                id oldVal = change[NSKeyValueChangeOldKey];
                id newVal = change[NSKeyValueChangeNewKey];
                if (![oldVal isEqual:newVal]) {
                    [self postBinderNotificationWithName:keyPath];
                }
            }];
        }
    }
    return binder;
}

- (void)postBinderNotificationWithName:(NSString *)name {
    for (NSString *nofiName in [[self binderWithKeyPath:name] getAllConditions]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:nofiName object:nil];
    }
}

- (NSMutableDictionary *)_bindersDic {
    NSMutableDictionary *bindersDic = objc_getAssociatedObject(self, _cmd);
    if (bindersDic) {
        bindersDic = [NSMutableDictionary dictionary];
        [self _setBindersDic:bindersDic];
    }
    return bindersDic;
}

- (void)_setBindersDic:(NSMutableDictionary *)binderDic {
    objc_setAssociatedObject(self, @selector(_bindersDic), binderDic, OBJC_ASSOCIATION_RETAIN);
}

@end
