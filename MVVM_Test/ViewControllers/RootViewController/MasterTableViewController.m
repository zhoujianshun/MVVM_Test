//
//  MasterTableViewController.m
//  MVVM_Test
//
//  Created by 周建顺 on 16/4/8.
//  Copyright © 2016年 周建顺. All rights reserved.
//

#import "MasterTableViewController.h"
#import "MasterViewModel.h"
#import "DetailViewController.h"

@interface MasterTableViewController ()

@property (nonatomic,strong) MasterViewModel *viewModel;
@property (nonatomic) BOOL refreshing;

@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.viewModel = [[MasterViewModel alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateView:) name:MasterVM_DataSource_Update object:nil];
    [self.viewModel addObserver:self forKeyPath:@"refreshing" options:NSKeyValueObservingOptionNew context:nil];
    [self.refreshControl addTarget:self
                            action:@selector(RefreshViewControlEventValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.viewModel requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.viewModel removeObserver:self forKeyPath:@"refreshing"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"refreshing"]) {
        self.refreshing = [[change valueForKey:NSKeyValueChangeNewKey] boolValue];
    }
}

-(void)RefreshViewControlEventValueChanged:(UIRefreshControl*)sender{
    NSLog(@"RefreshViewControlEventValueChanged");
    [self.viewModel requestData];
}

#pragma mark - setter

-(void)setRefreshing:(BOOL)refreshing{
    if (refreshing) {
        [self.refreshControl beginRefreshing];
    }else{
        [self.refreshControl endRefreshing];
    }
}

-(BOOL)refreshing{
    return self.refreshControl.refreshing;
}

#pragma mark - update view
-(void)updateView:(NSNotification*)notification{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.viewModel titleAtIndexPath:indexPath];
    cell.detailTextLabel.text = [self.viewModel subTitleAtIndexPath:indexPath];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.viewModel deleteItemAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"pushToDetailViewController"]) {
        
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.viewModel = [self.viewModel detailViewModelAtIndexPath:indexPath];
    }
}


@end
