//
//  main.m
//  PHOAssociation
//
//  Created by Phoenix on 2018/2/26.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person+Test.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *boy = Person.new;
        @autoreleasepool {
            Person *girl = Person.new;
            boy.lover = girl;
            NSLog(@"lover: %@", boy.lover);
        }
        NSLog(@"lover: %@", boy.lover);
    }
    return 0;
}
