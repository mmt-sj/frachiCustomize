//
//  IntellectAddViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/11/2.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "IntellectAddViewController.h"
#import "MtTextField.h"
#import "mtButton.h"
#import "Device.h"
#import "XHToast.h"



@interface IntellectAddViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MtTextField *ssidTextField;
@property(nonatomic,strong)MtTextField *passwordTextField;
@property(nonatomic,strong)UISwitch *isOneDeviceSwitch;
@property(nonatomic,strong)mtButton *mtbutton;

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation IntellectAddViewController{
    NSMutableArray *_muAddDevice;
    
    HFSmartLink * smtlk;
    BOOL isconnecting;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"智能添加設備";
    self.view.backgroundColor=[UIColor whiteColor];
    _muAddDevice=[[NSMutableArray alloc]init];
    [self addView];
    
    smtlk = [HFSmartLink shareInstence];
    smtlk.isConfigOneDevice = true;
    smtlk.waitTimers = 30;
    isconnecting=false;
    self.isOneDeviceSwitch.on=smtlk.isConfigOneDevice;
    [self showWifiSsid];
    self.passwordTextField.text=[self getPwdBySsid:self.ssidTextField.text];


}
-(void)showWifiSsid
{
    BOOL wifiOK=FALSE;
    NSDictionary *ifs;
    NSString *ssid;
    if(!wifiOK)
    {
        ifs=[self fetchSsidInfo];
        ssid=[ifs objectForKey:@"SSID"];
        if(ssid!=nil)
        {
            wifiOK=TRUE;
            self.ssidTextField.text=ssid;
        }
        else
        {
            [XHToast showSplitCenterWithText:@"請連接Wi-Fi!"];
        }
    }
    
}
-(id)fetchSsidInfo{
    NSArray *ifs=(__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"supported interfaces:%@",ifs);
    id info=nil;
    for (NSString *ifnam  in ifs) {
        info=(__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@=>%@",ifnam,info);
        if(info&&[info count]){
            break;
        }
        
    }
    return  info;
}
-(void)savePassword
{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:self.passwordTextField.text forKey:self.ssidTextField.text];
}
-(NSString *)getPwdBySsid:(NSString *)ssid
{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    return [def objectForKey:ssid];
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
-(void)connectStopInterface{
#warning message
}
-(void)connectStartInterface{
#warning message
}
-(void)addView{
    CGFloat boxX=self.view.frame.size.width/3-150;

    self.ssidTextField=[[MtTextField alloc]initWithFrame:CGRectMake(boxX, 100, 300, 30) Name:@"SSID"];
    self.ssidTextField.placeholder=@"請連接WIFI后重新打開該軟件(若連接后沒有SSID請手動輸入)";
    [self.view addSubview:self.ssidTextField];
    
    self.passwordTextField=[[MtTextField alloc]initWithFrame:CGRectMake(boxX, 140, 300, 30) Name:@"密碼"];
    self.passwordTextField.placeholder=@"請輸入房錢SSID的WIFI密碼";
    [self.view addSubview:self.passwordTextField];
    
    UILabel *switchLabel=[[UILabel alloc]initWithFrame:CGRectMake(boxX, 185, 200, 30)];
    switchLabel.text=@"配置單個設備";
    [self.view addSubview:switchLabel];
    
    self.isOneDeviceSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(boxX+300-50, 185, 50, 30)];
    [self.isOneDeviceSwitch setOn:YES];
    [self.isOneDeviceSwitch addTarget:self action:@selector(switchClick) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.isOneDeviceSwitch];
    
    self.mtbutton=[mtButton buttonWithFrame:CGRectMake(boxX, 230, 300, 40) title:@"開始配置" andBlock:^{
        
        [self.mtbutton setTitle:@"正在配置..." forState:UIControlStateNormal];
        
        /////////////////
        NSString* ssidStr=self.ssidTextField.text;
        NSString* pswdStr=self.passwordTextField.text;
        
        if(!isconnecting)
        {
            isconnecting=true;
            [self connectStartInterface];
            [smtlk startWithSSID:ssidStr Key:pswdStr withV3x:true processblock:^(NSInteger process) {
                //進度條
            } successBlock:^(HFSmartLinkDeviceInfo *dev) {
                [XHToast showSplitCenterWithText:[NSString stringWithFormat:@"%@:%@",dev.mac,dev.ip]];
                //將ip存儲到plist中
#warning 存储到数据库中
                //存储
                Device *device=[[Device alloc]init];
                if([device addDevice:(int)[device autoGetNumber] ColorID:(int)[device autoGetNumber] IP:dev.ip Port:@"8899" Type:0 Remark:@"智能添加"]){
                 [_muAddDevice addObject:device];
                    [self.tableView reloadData];
                }else{
                    [XHToast showSplitCenterWithText:@"添加失敗"];
                }
                //
                
            } failBlock:^(NSString *failmsg) {
                
                [XHToast showSplitCenterWithText:@"error"];
                [self.mtbutton setTitle:@"開始配置" forState:UIControlStateNormal];
                
            } endBlock:^(NSDictionary *deviceDic) {
                isconnecting=false;
                [self connectStopInterface];
                [self savePassword];
            }];
            //[self.btn_start setTitle:@"正在配置中..." forState:UIControlStateNormal];
        }
        else{
            [smtlk stopWithBlock:^(NSString *stopMsg, BOOL isOk) {//停止
                if(isOk)//停止成功
                {
                    [self.mtbutton setTitle:@"開始配置" forState:UIControlStateNormal];
                    isconnecting=false;
                    [self connectStopInterface];
                    [XHToast showSplitCenterWithText:stopMsg];
                }
                else//停止失敗
                {
                    [XHToast showSplitCenterWithText:@"error"];
                    [self.mtbutton setTitle:@"開始配置" forState:UIControlStateNormal];
                }
            }];
        }

        ////////////////////
        
        
    }];
    
    self.mtbutton.layer.masksToBounds=YES;
    self.mtbutton.layer.cornerRadius=5;
    [self.view addSubview:self.mtbutton];
    
    //tableview
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width-self.view.frame.size.width/3, self.view.frame.size.height-300) style:UITableViewStylePlain];
    //添加tableview 显示增加的设备
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(void)switchClick{
    if(self.isOneDeviceSwitch.on){
     smtlk.isConfigOneDevice = true;
    }else{
        smtlk.isConfigOneDevice = false;
    }
}
/*
 *tableview
 *
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _muAddDevice.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    if(_muAddDevice.count<1){
        cell.textLabel.text=@"還沒有添加設備";
    }else{
        Device *device=[[Device alloc]init];
        device=[_muAddDevice objectAtIndex:indexPath.row];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 40, 20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        cell.imageView.image=[UIImage imageNamed:@"底色"];
        cell.imageView.layer.masksToBounds=YES;
        cell.imageView.layer.cornerRadius=20;
        [cell.imageView addSubview:label];
        label.text=[NSString stringWithFormat:@"%d",device.ID];
        cell.textLabel.text=[NSString stringWithFormat:@"IP地址:%@:%@",device.ip,device.port];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"信息:%@",device.remark];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
