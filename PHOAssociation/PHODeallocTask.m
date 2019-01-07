//
//  PHODeallocTask.m
//  PHOAssociation
//
//  Created by Phoenix on 2018/2/26.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import "PHODeallocTask.h"

@interface PHODeallocTaskItem: NSObject
@property (nonatomic, weak, readonly) id target;
@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, copy, readonly) DeallocBlock task;

- (instancetype)initWithTarget:(id)target key:(NSString *)key task:(DeallocBlock)task;
+ (instancetype)taskItemWithTarget:(id)target key:(NSString *)key task:(DeallocBlock)task;
@end

@implementation PHODeallocTaskItem
- (instancetype)initWithTarget:(id)target key:(NSString *)key task:(DeallocBlock)task {
    self = [super init];
    if (self) {
        _target = target;
        _key = key;
        _task = [task copy];
    }
    return self;
}

+ (instancetype)taskItemWithTarget:(id)target key:(NSString *)key task:(DeallocBlock)task {
    return [[self alloc] initWithTarget:target key:key task:task];
}

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return YES;
    }
    else if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    else {
        PHODeallocTaskItem *another = (PHODeallocTaskItem *)object;
        return [another.target isEqual:self.target] && [another.key isEqualToString:self.key];
    }
}

- (NSUInteger)hash {
    NSObject *target = self.target;
    return (target.hash + self.key.hash);
}
@end


@interface PHODeallocTask()
@property (nonatomic, strong) NSMutableSet<PHODeallocTaskItem *> *taskSet;
@end

@implementation PHODeallocTask

- (void)addTask:(DeallocBlock)task
      forTarget:(id)target
            key:(NSString *)key {
    PHODeallocTaskItem *taskItem = [PHODeallocTaskItem taskItemWithTarget:target key:key task:task];
    if ([self.taskSet containsObject:taskItem]) {
        [self.taskSet removeObject:taskItem];
    }
    [self.taskSet addObject:taskItem];
}

- (void)removeTaskForTarget:(id)target key:(NSString *)key {
    PHODeallocTaskItem *taskItem = [PHODeallocTaskItem taskItemWithTarget:target key:key task:nil];
    [self.taskSet removeObject:taskItem];
}

- (void)dealloc {
    [self.taskSet enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHODeallocTaskItem * _Nonnull obj, BOOL * _Nonnull stop) {
        !obj.task ?: obj.task();
    }];
}

- (NSMutableSet *)taskSet {
    if (!_taskSet) {
        _taskSet = [NSMutableSet set];
    }
    return _taskSet;
}
@end


