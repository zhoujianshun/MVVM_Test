//
//  DetailViewController.m
//  MVVM_Test
//
//  Created by 周建顺 on 16/4/8.
//  Copyright © 2016年 周建顺. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *AgeLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.NameLabel.text = self.viewModel.personName;
    self.AgeLabel.text = [NSString stringWithFormat:@"%li",self.viewModel.personAge];
    
    self.nameTextField.text = self.viewModel.personName;
    self.ageTextField.text = [NSString stringWithFormat:@"%li",self.viewModel.personAge];
    
    [self.viewModel addObserver:self forKeyPath:@"personName" options:NSKeyValueObservingOptionNew context:nil];
    [self.viewModel addObserver:self forKeyPath:@"personAge" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)dealloc{
    [self.viewModel removeObserver:self forKeyPath:@"personName"];
    [self.viewModel removeObserver:self forKeyPath:@"personAge"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"personName"]) {
        self.NameLabel.text  = [change objectForKey:NSKeyValueChangeNewKey];
    }else if ([keyPath isEqualToString:@"personAge"]){
        self.AgeLabel.text = [NSString stringWithFormat:@"%@",[change objectForKey:NSKeyValueChangeNewKey]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nameTextChanged:(id)sender {
    self.viewModel.personName = self.nameTextField.text;
}
- (IBAction)ageTextChanged:(id)sender {
    NSString *str = self.ageTextField.text;
    self.viewModel.personAge = [str integerValue];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
