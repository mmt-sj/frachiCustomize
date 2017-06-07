//
//  SetPasswordViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/11/2.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "User.h"
#import "XHToast.h"
#define btnColor [UIColor colorWithRed:76/255.0 green:71/255.0 blue:68/255.0 alpha:1.0]

@interface SetPasswordViewController ()
@property(nonatomic,strong)UITextField* textfield;
@property(nonatomic,strong)UIButton* button;
@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"修改密碼";
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self addView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addView{
    self.textfield=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3-150, 100, 300, 30)];
    self.textfield.borderStyle=UITextBorderStyleRoundedRect;
    self.textfield.clearButtonMode=UITextFieldViewModeAlways;
    self.textfield.returnKeyType=UIReturnKeyDone;
    self.textfield.placeholder=@"請輸入密碼（長度6位以上）";
    [self.view addSubview:self.textfield];
    
    self.button=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3-150, 140, 300, 40)];
    self.button.layer.masksToBounds=YES;
    self.button.layer.cornerRadius=5;
    [self.button setTitle:@"确定" forState:UIControlStateNormal];
    self.button.titleLabel.textColor=[UIColor whiteColor];
    self.button.backgroundColor=btnColor;
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
}
-(void)buttonClick{
    if(self.textfield.text.length>6){
        NSString *newPwd=self.textfield.text;
        User *user=[[User alloc]init];
        if(([user editPassword:newPwd Name:@"admin"])){
            [XHToast showCenterWithText:@"修改成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [XHToast showSplitCenterWithText:@"修改失敗"];
        }
    }else{
        [XHToast showSplitCenterWithText:@"輸入的密碼長度必須大於6位"];
    }
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
