//
//  NSObject+PHOAssociation.h
//  PHOAssociation
//
//  Created by Phoenix on 2018/2/26.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PHOAssociationPolicy) {
    PHOAssociationPolicyAssign,
    PHOAssociationPolicyWeak,
    PHOAssociationPolicyRetain,
    PHOAssociationPolicyCopy,
    PHOAssociationPolicyRetainNonatomic,
    PHOAssociationPolicyCopyNonatomic
};

@interface NSObject (PHOAssociation)
- (void)setAssociatedObject:(id)object
                     forKey:(NSString *)key
                association:(PHOAssociationPolicy)policy;

- (id)associatedObjectForKey:(NSString *)key;
@end
