//
//  DetailViewController.h
//  MVVM_Test
//
//  Created by 周建顺 on 16/4/8.
//  Copyright © 2016年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewModel.h"


@interface DetailViewController : UIViewController

@property (nonatomic,strong) DetailViewModel *viewModel;

@end
