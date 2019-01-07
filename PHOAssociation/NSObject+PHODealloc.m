//
//  NSObject+PHODealloc.m
//  PHOAssociation
//
//  Created by Phoenix on 2018/2/26.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import "NSObject+PHODealloc.h"
#import "PHODeallocTask.h"
#import <objc/runtime.h>

static const char TaskKey = '0';

@implementation NSObject (PHODealloc)
- (PHODeallocTask *)deallocTask {
    PHODeallocTask *task = objc_getAssociatedObject(self, &TaskKey);
    if (!task) {
        task = [PHODeallocTask new];
        objc_setAssociatedObject(self, &TaskKey, task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return task;
}

- (void)addDeallocTask:(DeallocBlock)task
             forTarget:(id)target
                   key:(NSString *)key {
    
    [self.deallocTask addTask:task forTarget:target key:key];
}

- (void)removeDeallocTaskForTarget:(id)target
                               key:(NSString *)key {
    [self.deallocTask removeTaskForTarget:target key:key];
}
@end
