//
//  Person.m
//  MVVM_Test
//
//  Created by 周建顺 on 16/4/8.
//  Copyright © 2016年 周建顺. All rights reserved.
//

#import "Person.h"

@implementation Person

-(instancetype)initWithName:(NSString*)name age:(NSUInteger)age{
    self = [super init];
    if (self) {
        self.name = name;
        self.age = age;
    }
    return self;
}

@end
