//
//  Person.h
//  MVVM_Test
//
//  Created by 周建顺 on 16/4/8.
//  Copyright © 2016年 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic) NSUInteger age;

-(instancetype)initWithName:(NSString*)name age:(NSUInteger)age;

@end
