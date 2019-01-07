//
//  NSObject+PHODealloc.h
//  PHOAssociation
//
//  Created by Phoenix on 2018/2/26.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DeallocBlock)(void);

@interface NSObject (PHODealloc)
- (void)addDeallocTask:(DeallocBlock)task
             forTarget:(id)target
                   key:(NSString *)key;

- (void)removeDeallocTaskForTarget:(id)target
                               key:(NSString *)key;
@end
