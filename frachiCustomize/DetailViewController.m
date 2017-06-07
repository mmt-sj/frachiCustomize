//
//  DetailViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/11/1.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "DetailViewController.h"
#import "Device.h"
#import "SetPasswordViewController.h"
#import "AddDeviceViewController.h"
#import "IntellectAddViewController.h"
#import "XHToast.h"
#import "DeviceDetailViewController.h"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation DetailViewController{
    NSMutableArray *_deviceData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"所有設備";
    self.tableView.delegate=self;
    
    //init data
    Device *device=[[Device alloc]init];
    NSMutableArray *muArray=[device selectAllDevice];
    _deviceData=muArray;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Device *device=[[Device alloc]init];
    _deviceData=[device selectAllDevice];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Device *device=[[Device alloc]init];
    NSMutableArray *muArray=[device selectAllDevice];
    NSLog(@"數量%lu",(unsigned long)muArray.count);
    return muArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 40, 20)];
        if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        [cell.imageView addSubview:label];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imageView.image=[UIImage imageNamed:@"底色"];
            cell.imageView.layer.cornerRadius=20;
            cell.imageView.layer.masksToBounds=YES;
            label.font=[UIFont systemFontOfSize:20 weight:8];
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
    }
    if(_deviceData.count>0){
        Device *device=[[Device alloc]init];
        device=[_deviceData objectAtIndex:indexPath.row];
          label=(UILabel *)cell.imageView.subviews.firstObject;
        label.text=[NSString stringWithFormat:@"%d",device.ID];//此label非彼label
        cell.textLabel.text=[NSString stringWithFormat:@"IP地址:%@:%@",device.ip,device.port];
      
        cell.detailTextLabel.text=[NSString stringWithFormat:@"信息:%@",device.remark];

    }else{
        cell.textLabel.text=@"沒有設備";
    }
    for (Device* temp in _deviceData) {
        NSLog(@"ID is what?%d",temp.ID);
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Device *device=[[Device alloc]init];
    device=[_deviceData objectAtIndex:indexPath.row];
    DeviceDetailViewController *deviceDetailView=[[DeviceDetailViewController alloc]init];
    deviceDetailView.deviceID=device.ID;
    NSLog(@"%d",(int)device.ID);
    [self.navigationController pushViewController:deviceDetailView animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        Device *tempID=[_deviceData objectAtIndex:indexPath.row];
        if([tempID deleteDevice:tempID.ID]){
            [XHToast showSplitCenterWithText:@"刪除成功"];
            _deviceData=[tempID selectAllDevice];
            [self.tableView reloadData];
            
        }else{
            [XHToast showSplitCenterWithText:@"刪除失敗"];
        }
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"刪除";
}
-(void)ConfigView{
    if([self.detailItem isEqualToString:@"allDevice"]){
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    if([self.detailItem isEqualToString:@"intelligenceAdd"]){
        IntellectAddViewController *intellectAddDevice=[[IntellectAddViewController alloc]init];
        intellectAddDevice.navigationItem.hidesBackButton=YES;
        [self.navigationController pushViewController:intellectAddDevice animated:NO];
    }
    if([self.detailItem isEqualToString:@"add"]){
        AddDeviceViewController *addDevice=[[AddDeviceViewController alloc]init];
        addDevice.navigationItem.hidesBackButton=YES;
        [self.navigationController pushViewController:addDevice animated:NO];
    }
    if([self.detailItem isEqualToString:@"setPassword"]){
        SetPasswordViewController *setPassword=[[SetPasswordViewController alloc]init];
        setPassword.navigationItem.hidesBackButton=YES;
        [self.navigationController pushViewController:setPassword animated:NO];
    }
  
}
-(void)setDetailItem:(NSString *)detailItem{
    if(_detailItem!=detailItem){
        _detailItem=detailItem;
        [self ConfigView];
    }
}
@end
