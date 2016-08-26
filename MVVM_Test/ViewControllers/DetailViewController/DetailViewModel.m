//
//  DetailViewModel.m
//  MVVM_Test
//
//  Created by 周建顺 on 16/4/8.
//  Copyright © 2016年 周建顺. All rights reserved.
//

#import "DetailViewModel.h"

@interface DetailViewModel ()

@property (nonatomic,strong) Person *person;

@end

@implementation DetailViewModel

-(instancetype)initWithPerson:(Person*)person{
    self = [super init];
    if (self) {
        self.person = person;
    }
    return self;
}


-(void)setPerson:(Person *)person{
    _person = person;

    
    // kvo 通知
    [self willChangeValueForKey:@"personName"];
    _personName = person.name;
    [self didChangeValueForKey:@"personName"];
    
    [self willChangeValueForKey:@"personAge"];
    _personAge = person.age;
    [self didChangeValueForKey:@"personAge"];
    
}


-(void)setPersonName:(NSString *)personName{
    _personName = personName;
}

-(void)setPersonAge:(NSUInteger)personAge{
    _personAge = personAge;
}



@end
