//
//  MasterViewModel.m
//  MVVM_Test
//
//  Created by 周建顺 on 16/4/8.
//  Copyright © 2016年 周建顺. All rights reserved.
//

#import "MasterViewModel.h"
#import "Person.h"
#import <UIKit/UIKit.h>

@interface MasterViewModel()

@property (nonatomic,strong) NSMutableArray *dataSource;


@end

@implementation MasterViewModel

-(void)requestData{
    self.refreshing = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dataSource = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 20; i++) {
            Person *person = [[Person alloc] initWithName:[NSString stringWithFormat:@"name%i",i] age:20+i];
            [self.dataSource addObject:person];
        }
        
        sleep(3);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.refreshing = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:MasterVM_DataSource_Update object:nil];
        });
    });
    

}

- (NSInteger)numberOfSections{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

-(NSString*)titleAtIndexPath:(NSIndexPath*)indexPath{
    Person *person = [self.dataSource objectAtIndex:indexPath.row];
    return [NSString stringWithFormat:@"姓名：%@",person.name];
}

-(NSString*)subTitleAtIndexPath:(NSIndexPath*)indexPath{
    Person *person = [self.dataSource objectAtIndex:indexPath.row];
    return [NSString stringWithFormat:@"年龄：%li",person.age];
}

-(DetailViewModel*)detailViewModelAtIndexPath:(NSIndexPath*)indexPath{
    Person *person = [self.dataSource objectAtIndex:indexPath.row];
    DetailViewModel *vm = [[DetailViewModel alloc] initWithPerson:person];
    
    return vm;
}

-(void)deleteItemAtIndexPath:(NSIndexPath*)path{
    [self.dataSource removeObjectAtIndex:path.row];
}

@end
