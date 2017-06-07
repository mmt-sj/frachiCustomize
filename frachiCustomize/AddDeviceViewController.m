//
//  AddDeviceViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/11/2.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "MtTextField.h"
#import "XHToast.h"
#import "Device.h"
#define btnColor [UIColor colorWithRed:76/255.0 green:71/255.0 blue:68/255.0 alpha:1.0]
@interface AddDeviceViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)MtTextField *number;
@property(nonatomic,strong)MtTextField *ip;
@property(nonatomic,strong)MtTextField *port;
@property(nonatomic,strong)MtTextField *remark;
@property(nonatomic,strong)UIPickerView *type;
@end

@implementation AddDeviceViewController{
    int _typeNumer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"手動添加設備";
    self.view.backgroundColor=[UIColor whiteColor];
    [self addView];
    [self initTextFieldValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addView{
    //
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
    
    //label
    UILabel *typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 100, 30)];
    typeLabel.text=@"設備類型";
    [self.type addSubview:typeLabel];
    _typeNumer=0;
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(boxX, 340, 300, 40)];
    [button setTitle:@"確定" forState:UIControlStateNormal];
    button.backgroundColor=btnColor;
    button.titleLabel.textColor=[UIColor whiteColor];
    button.layer.masksToBounds=YES;
    button.layer.cornerRadius=5;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)buttonClick{
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
                if([device addDevice:[self.number.text intValue]ColorID:[self.number.text intValue] IP:self.ip.text Port:self.port.text Type:_typeNumer Remark:self.remark.text]){
                    [XHToast showSplitCenterWithText:@"設備添加成功！"];
                    [self initTextFieldValue];
                }else{
                    [XHToast showSplitCenterWithText:@"該編號的設備已經存在"];
                }
            }
        }

    }
    
}
-(void)initTextFieldValue{
    Device *device=[[Device alloc]init];
    
    self.number.text=[NSString stringWithFormat:@"%d",(int)[device autoGetNumber]];
    self.ip.text=@"";
    self.port.text=@"8899";
    self.remark.text=@"";
    [self.type selectRow:0 inComponent:0 animated:YES];
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
