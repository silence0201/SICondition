//
//  SIBinder.h
//  SIConditionDemo
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef BOOL(^BinderRule)(id obj);

@interface SIBinder : NSObject

@property (nonatomic, weak) id target;

- (void)binderRule:(BinderRule) rule toCondition:(NSString *)condition;

- (BinderRule)binderRuleForCondition:(NSString *)condition;

- (NSArray *)getAllConditions;

@end

NS_ASSUME_NONNULL_END
