//
//  Person+Test.m
//  PHOAssociation
//
//  Created by Phoenix on 2018/2/26.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import "Person+Test.h"

@implementation Person (Test)
- (void)setLover:(Person *)lover {
    [self setAssociatedObject:lover
                       forKey:@"lover"
                  association:PHOAssociationPolicyWeak];
}

- (Person *)lover {
    return [self associatedObjectForKey:@"lover"];
}
@end
