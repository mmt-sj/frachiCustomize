//
//  LoginViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/10/27.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "LoginViewController.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "User.h"
#import "XHToast.h"
#define test 1
@interface LoginViewController ()
- (IBAction)exitButton;
- (IBAction)loginButton;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *userPasswordTextField;

@property(nonatomic,strong)UISplitViewController *splitViewController;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)exitButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButton {
    //nav
//     NavRootViewController *navRoot=[[NavRootViewController alloc]init];
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:navRoot];
//    [self presentViewController:nav animated:YES completion:nil];
    
    User *user=[[User alloc]init];
    if(([user selectUser:self.userNameTextField.text Password:self.userPasswordTextField.text])||test){
        self.splitViewController=[[UISplitViewController alloc]init];
        
        MasterViewController *masterViewController=[[MasterViewController alloc]initWithStyle:UITableViewStyleGrouped];
        DetailViewController *detailViewController=[[DetailViewController alloc]init];
        
        UINavigationController *masterNav=[[UINavigationController alloc]initWithRootViewController:masterViewController];
        UINavigationController *detailNav=[[UINavigationController alloc]initWithRootViewController:detailViewController];
        
        masterViewController.detailViewController=detailViewController;
        
        self.splitViewController.viewControllers=@[masterNav,detailNav];
        self.splitViewController.delegate=detailViewController;
        
        [self presentViewController:self.splitViewController animated:YES completion:nil];
    }else{
        [XHToast showCenterWithText:@"賬號或密碼錯誤"];
    }
    
    //splitviewcontroller

}
@end
