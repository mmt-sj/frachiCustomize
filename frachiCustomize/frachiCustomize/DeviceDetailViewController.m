//
//  DeviceDetailViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/11/3.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "Device.h"
#import "MtTextField.h"
#import "XHToast.h"
#define btnColor [UIColor colorWithRed:76/255.0 green:71/255.0 blue:68/255.0 alpha:1.0]
@interface DeviceDetailViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)MtTextField *number;
@property(nonatomic,strong)MtTextField *ip;
@property(nonatomic,strong)MtTextField *port;
@property(nonatomic,strong)MtTextField *remark;
@property(nonatomic,strong)UIPickerView *type;

@property(nonatomic,strong)UIButton *button;
@end

@implementation DeviceDetailViewController{
    Device* _device;
    int _typeNumer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"設備詳情";
    _device=[[Device alloc]init];
    _device=[_device selectOneDevice:(int)self.deviceID];
    [self addView];
    [self initData];
    [self setUITextfield:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addView{
    CGFloat boxX=self.view.frame.size.width/3-150;
    self.number=[[MtTextField alloc]initWithFrame:CGRectMake(boxX, 100, 300, 30) Name:@"編號"];
    self.number.placeholder=@"請輸入編號";
    self.number.delegate=self;
    [self.view addSubview:self.number];
    self.ip=[[MtTextField alloc]initWithFrame:CGRectMake(boxX, 140, 300, 30) Name:@"I P"];
    self.ip.placeholder=@"請輸入IP地址(192.168.0.100)";
    self.ip.delegate=self;
    [self.view addSubview:self.ip];
    self.port=[[MtTextField alloc]initWithFrame:CGRectMake(boxX, 180, 300,30 ) Name:@"端口"];
    self.port.placeholder=@"請輸入端口號";
    self.port.delegate=self;
    [self.view addSubview:self.port];
    self.remark=[[MtTextField alloc]initWithFrame:CGRectMake(boxX, 220, 300, 30) Name:@"備註"];
    self.remark.placeholder=@"請輸入備註";
    self.remark.delegate=self;
    [self.view addSubview:self.remark];
    self.type=[[UIPickerView alloc]initWithFrame:CGRectMake(boxX, 260, 300, 60)];
    self.type.delegate=self;
    self.type.showsSelectionIndicator=YES;
    [self.view addSubview:self.type];
    UILabel *typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 100, 30)];
    typeLabel.text=@"設備類型";
    [self.type addSubview:typeLabel];
    self.button=[[UIButton alloc]initWithFrame:CGRectMake(boxX, 340, 300, 40)];
    [self.button setTitle:@"編輯" forState:UIControlStateNormal];
    self.button.tag=0;
    self.button.backgroundColor=btnColor;
    self.button.titleLabel.textColor=[UIColor whiteColor];
    self.button.layer.masksToBounds=YES;
    self.button.layer.cornerRadius=5;
    [self.button addTarget:self action:@selector(buttonClicks) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}
-(void)initData{
    self.number.text=[NSString stringWithFormat:@"%d",(int)_device.ID];
    self.ip.text=_device.ip;
    self.port.text=_device.port;
    self.remark.text=_device.remark;
    _typeNumer=_device.type;
    [self.type selectRow:_device.type inComponent:0 animated:YES];
}
-(void)setUITextfield:(BOOL)is{
    self.number.userInteractionEnabled=is;
    self.ip.userInteractionEnabled=is;
    self.port.userInteractionEnabled=is;
    self.remark.userInteractionEnabled=is;
    self.type.userInteractionEnabled=is;
}
-(void)buttonClicks{
    if(self.button.tag==0){
        [self setUITextfield:YES];
        self.button.tag=1;
        [self.button setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        if(self.ip.text.length<5){
            [XHToast showSplitCenterWithText:@"IP地址輸入不正確！"];
            return;
        }else{
            if(self.number.text.length<=0){
                [XHToast showSplitCenterWithText:@"編號輸入不正確!"];
                return;
            }else{
                if(self.port.text.length<=0){
                    [XHToast showSplitCenterWithText:@"端口輸入不正確！"];
                }else{
                    
                    Device *device=[[Device alloc]init];
                    if([device editDeviceNewID:[self.number.text intValue] OldID:_device.ID ColorID:[self.number.text intValue] IP:self.ip.text Port:self.port.text Type:_typeNumer Remark:self.remark.text]){
                        [XHToast showSplitCenterWithText:@"修改成功！"];
                        [self setUITextfield:NO];
                        [self.button setTitle:@"編輯" forState:UIControlStateNormal];
                        self.button.tag=0;
                    }else{
                        [XHToast showSplitCenterWithText:@"該編號的設備已經存在，请重新填写修改的编号"];
                    }
                     }
                }
            }

    }
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (row) {
        case 0:
            return @"0";
            break;
        case 1:
            return @"1";
            break;
        case 2:
            return @"2";
            break;
        default:
            return @"0";
            break;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _typeNumer=(int)row;
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
