//
//  NSObject+PHOAssociation.m
//  PHOAssociation
//
//  Created by Phoenix on 2018/2/26.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import "NSObject+PHOAssociation.h"
#import <objc/runtime.h>
#import "NSObject+PHODealloc.h"

static NSMutableDictionary *keyBuffer;

@implementation NSObject (PHOAssociation)

+ (void)load {
    keyBuffer = [NSMutableDictionary dictionary];
}

- (void)setAssociatedObject:(id)object
                     forKey:(NSString *)key
                association:(PHOAssociationPolicy)policy {
    
    const char *cKey = [keyBuffer[key] pointerValue];
    if (cKey == NULL) {
        cKey = key.UTF8String;
        keyBuffer[key] = [NSValue valueWithPointer:cKey];
    }
    switch (policy) {
        case PHOAssociationPolicyAssign:
            objc_setAssociatedObject(self, cKey, object, OBJC_ASSOCIATION_ASSIGN);
            break;
        case PHOAssociationPolicyRetain:
            objc_setAssociatedObject(self, cKey, object, OBJC_ASSOCIATION_RETAIN);
            break;
        case PHOAssociationPolicyRetainNonatomic:
            objc_setAssociatedObject(self, cKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            break;
        case PHOAssociationPolicyCopy:
            objc_setAssociatedObject(self, cKey, object, OBJC_ASSOCIATION_COPY);
            break;
        case PHOAssociationPolicyCopyNonatomic:
            objc_setAssociatedObject(self, cKey, object, OBJC_ASSOCIATION_COPY_NONATOMIC);
            break;
        case PHOAssociationPolicyWeak:
            [self _setWeakObject:object forKey:key];
            break;
    }
}

- (void)_setWeakObject:(id)object forKey:(NSString *)key {
    const char *cKey = [keyBuffer[key] pointerValue];
    __weak __typeof(self) weakSelf = self;
    
    id oldObject = objc_getAssociatedObject(self, cKey);
    [oldObject removeDeallocTaskForTarget:self key:key];
    
    objc_setAssociatedObject(self, cKey, object, OBJC_ASSOCIATION_ASSIGN);
    [object addDeallocTask:^{
        objc_setAssociatedObject(weakSelf, cKey, nil, OBJC_ASSOCIATION_ASSIGN);
    } forTarget:self key:key];
}

- (id)associatedObjectForKey:(NSString *)key {
    const char *cKey = [keyBuffer[key] pointerValue];
    if (cKey == NULL) {
        return nil;
    }
    else {
        return objc_getAssociatedObject(self, cKey);
    }
}
@end
