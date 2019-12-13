//
//  SICondition.h
//  SIConditionDemo
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIBinder.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConditionCallBack)(id weakTarget, BOOL result);

@interface SICondition : NSObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, weak) id target;
@property (nonatomic, copy) ConditionCallBack callBack;

- (instancetype)initWithName:(NSString *)name;

- (void)addBinder:(SIBinder *)binder withRule:(BinderRule)rule;

- (void)nofityListener;


@end

NS_ASSUME_NONNULL_END
