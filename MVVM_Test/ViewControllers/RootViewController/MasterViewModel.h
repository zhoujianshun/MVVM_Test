//
//  MasterViewModel.h
//  MVVM_Test
//
//  Created by 周建顺 on 16/4/8.
//  Copyright © 2016年 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewModel.h"

#define MasterVM_DataSource_Update @"MasterVM_DataSource_Update"

@interface MasterViewModel : NSObject

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

-(NSString*)titleAtIndexPath:(NSIndexPath*)indexPath;
-(NSString*)subTitleAtIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic) BOOL refreshing;

-(DetailViewModel*)detailViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)requestData;
-(void)deleteItemAtIndexPath:(NSIndexPath*)path;

@end
