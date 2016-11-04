//
//  MasterViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/11/1.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "MasterViewController.h"
#import "SetPasswordViewController.h"
@interface MasterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MasterViewController{

}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"設置";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.delegate=self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;

        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if(indexPath.section==0){
        cell.textLabel.text=@"所有設備";
    }
    if(indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"智能添加設備";
                break;
            case 1:
                cell.textLabel.text=@"手動添加設備";
            default:
                break;
        }
    }
    if(indexPath.section==2){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"修改密碼";
                break;
            case 1:
                cell.textLabel.text=@"退出";
                cell.textLabel.textColor=[UIColor redColor];
            default:
                break;
        }

    }
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        self.detailViewController.detailItem=@"allDevice";
    }
    if(indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                self.detailViewController.detailItem=@"intelligenceAdd";
                break;
            case 1:
                 self.detailViewController.detailItem=@"add";
            default:
                break;
        }
    }
    if(indexPath.section==2){
        switch (indexPath.row) {
            case 0:
                 self.detailViewController.detailItem=@"setPassword";
                break;
            case 1:
                [self dismissViewControllerAnimated:YES completion:nil];
            default:
                break;
        }
        
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
