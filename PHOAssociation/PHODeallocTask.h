//
//  PHODeallocTask.h
//  PHOAssociation
//
//  Created by Phoenix on 2018/2/26.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PHODealloc.h"

@interface PHODeallocTask : NSObject

- (void)addTask:(DeallocBlock)task
      forTarget:(id)target
            key:(NSString *)key;

- (void)removeTaskForTarget:(id)target
                        key:(NSString *)key;
@end
