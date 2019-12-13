//
//  SICondition.m
//  SIConditionDemo
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SICondition.h"

@interface SICondition ()

@property (nonatomic, strong) NSMutableArray *binders;
@property (nonatomic, copy) NSString *name;

@end

@implementation SICondition

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nofityListener) name:name object:nil];
    }
    return self;
}

- (NSMutableArray *)binders {
    if (!_binders) {
        _binders = [NSMutableArray array];
    }
    return _binders;
}

- (void)addBinder:(SIBinder *)binder withRule:(BinderRule)rule {
    if (binder == nil || rule == nil) return;
    [self.binders addObject:binder];
    [binder binderRule:rule toCondition:self.name];
}

- (void)nofityListener {
    BOOL result = YES;
    for (SIBinder *binder in self.binders) {
        BinderRule rule = [binder binderRuleForCondition:self.name];
        if (rule) {
            result = result && rule(self.target);
        }
    }
    
    if (self.callBack) {
        self.callBack(self.target, result);
    }
}

@end
