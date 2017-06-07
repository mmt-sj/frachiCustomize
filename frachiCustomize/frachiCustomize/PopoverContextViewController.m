//
//  PopoverContextViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/11/4.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "PopoverContextViewController.h"
#import "mtButton.h"
#import "Device.h"
#import "AsyncSocket.h"
#import "deviceString.h"
#import "XHToast.h"
@interface PopoverContextViewController ()<AsyncSocketDelegate>
@property(nonatomic,strong)UILabel* deviceInfo;

@property(nonatomic,strong)mtButton* lampABtn;
@property(nonatomic,strong)mtButton* lampOff;
@property(nonatomic,strong)mtButton* lampBBtn;
@property(nonatomic,strong)mtButton* doorOpen;
@property(nonatomic,strong)mtButton* doorStop;
@property(nonatomic,strong)mtButton* doorClose;

@property(nonatomic,strong)AsyncSocket* asyncSocket;

@property(nonatomic,assign)int DOORSTATE;
@property(nonatomic,assign)int LAMPASTATE;
@property(nonatomic,assign)int LAMPBSTATE;

@end

@implementation PopoverContextViewController{
    NSString *_deviceIP;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addViewType:self.type];
    [self initData];
    //初始化ASync
    self.asyncSocket=[[AsyncSocket alloc]initWithDelegate:self];
    //链接
    Device *device=[[Device alloc]init];
    device=[device selectOneDevice:self.deviceID];
    _deviceIP=device.ip;
    self.textView.text=[NSString stringWithFormat:@"%@\r\n%@： %@ connecting...",self.textView.text,[self nowTime],_deviceIP];
    if([self connectSocketIP:device.ip port:[device.port intValue]]){
        //发送心跳检测
    }else{
        [XHToast showCenterWithText:@"連接失敗"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initData{
    Device *device=[[Device alloc]init];
    device=[device selectOneDevice:self.deviceID];
    self.deviceInfo.text=[NSString stringWithFormat:@"設備信息：%@",device.remark];
}
-(void)addViewType:(int)type{
    
    self.deviceInfo=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 370, 60)];
    self.deviceInfo.numberOfLines=0;
    self.deviceInfo.text=@"設備信息：";
    [self.view addSubview:self.deviceInfo];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(15, 100-20, 370, 2)];
    line.backgroundColor=[UIColor grayColor];
    [self.view addSubview:line];
    
     CGFloat viewW=400;
    CGFloat btnW=110;
    CGFloat btnH=90;
    CGFloat margin=(viewW-3*btnW)/3;
    CGFloat doorHeight=100;
    if(type!=0&&type!=1){
        doorHeight=0;
    }
        self.lampABtn=[mtButton touchUpOutsideCancelButtonWithFrame:CGRectMake(margin/2, doorHeight, btnW, btnH) title:@"燈 A\r\nLAMP A" andBlock:^{
            [self sendData:LAMPA State:LAMPOPEN];
            [NSThread sleepForTimeInterval:1];
            [self sendData:LAMPB State:LAMPCLOSE];
        }];

        self.lampOff=[mtButton touchUpOutsideCancelButtonWithFrame:CGRectMake(margin/2+margin+btnW, doorHeight, btnW, btnH) title:@"燈 關\r\nLAMP CLOSE" andBlock:^{
            [self sendData:LAMPA State:LAMPCLOSE];
            [NSThread sleepForTimeInterval:1];
            [self sendData:LAMPB State:LAMPCLOSE];
        }];
        self.lampBBtn=[mtButton touchUpOutsideCancelButtonWithFrame:CGRectMake(margin/2+margin*2+btnW*2, doorHeight, btnW, btnH) title:@"燈 B\r\nLAMP B" andBlock:^{
            [self sendData:LAMPA State:LAMPCLOSE];
            [NSThread sleepForTimeInterval:1];
            [self sendData:LAMPB State:LAMPOPEN];
        }];
        self.doorOpen=[mtButton touchUpOutsideCancelButtonWithFrame:CGRectMake(margin/2, doorHeight+100, btnW, btnH) title:@"門開 \r\nOPEN" andBlock:^{
            [self sendData:DOOR State:DOOROPEN];
        }];
        self.doorStop=[mtButton touchUpOutsideCancelButtonWithFrame:CGRectMake(margin/2+margin+btnW, doorHeight+100, btnW, btnH) title:@"們停\r\nSTOP" andBlock:^{
            [self sendData:DOOR State:DOORSTOP];
        }];
        self.doorClose=[mtButton touchUpOutsideCancelButtonWithFrame:CGRectMake(margin/2+margin*2+btnW*2, doorHeight+100, btnW, btnH) title:@"門關\r\nCLOSE" andBlock:^{
            [self sendData:DOOR State:DOORCLOSE];
        }];
    //为按钮添加状态提示
    [self.lampABtn addStatusView];
    [self.lampBBtn addStatusView];
    [self.lampOff addStatusView];
    [self.doorOpen addStatusView];
    [self.doorStop addStatusView];
    [self.doorClose addStatusView];
    if(type==0){
        [self.view addSubview:self.lampABtn];
        [self.view addSubview:self.lampOff];
        [self.view addSubview:self.lampBBtn];
        [self.view addSubview:self.doorOpen];
        [self.view addSubview:self.doorStop];
        [self.view addSubview:self.doorClose];
    }
    if(type==1){
        [self.view addSubview:self.lampABtn];
        [self.view addSubview:self.lampOff];
        [self.view addSubview:self.lampBBtn];
    }
    if(type==2){
        [self.view addSubview:self.doorOpen];
        [self.view addSubview:self.doorStop];
        [self.view addSubview:self.doorClose];
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
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"%@",data);
    if(data.length<10){
        [self recData:data];
        [self setButtonstatus];
//          self.textView.text=[NSString stringWithFormat:@"%@\r\n%@： %@ operation is successful.",self.textView.text,[self nowTime],_deviceIP];
        [self.textView scrollRectToVisible:CGRectMake(0, self.textView.contentSize.height-15, self.textView.contentSize.width, 10) animated:NO];
        
    }
}
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"已经发送数据");
    // [self.asyncSocket readDataToLength:8 withTimeout:1 tag:0];
    [self.asyncSocket readDataWithTimeout:-1 tag:0];
      [self.textView scrollRectToVisible:CGRectMake(0, self.textView.contentSize.height-15, self.textView.contentSize.width, 10) animated:NO];
}
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    self.textView.text=[NSString stringWithFormat:@"%@\r\n%@： %@ connect success!",self.textView.text,[self nowTime],_deviceIP];
    [self heartbeats];
    [self.asyncSocket readDataWithTimeout:-1 tag:1];
}
-(void)setButtonstatus{
    //设置button的状态
    [UIView animateWithDuration:0.2 animations:^{
        if(self.LAMPASTATE==0&&self.LAMPBSTATE==0){
            [self.lampOff setStatusColor:[UIColor greenColor]];
            [self.lampABtn setStatusColor:btnColor];
            [self.lampBBtn setStatusColor:btnColor];
            
            
        }else{
            if(self.LAMPASTATE==1){
                [self.lampABtn setStatusColor:[UIColor greenColor]];
                [self.lampBBtn setStatusColor:btnColor];
                [self.lampOff setStatusColor:btnColor];

            }else{
                [self.lampBBtn setStatusColor:[UIColor greenColor]];
                [self.lampABtn setStatusColor:btnColor];
                [self.lampOff setStatusColor:btnColor];
            }
        }
        switch (self.DOORSTATE) {
            case DOOROPEN:
                [self.doorOpen setStatusColor:[UIColor greenColor]];
                [self.doorStop setStatusColor:btnColor];
                [self.doorClose setStatusColor:btnColor];
                break;
            case DOORSTOP:
                [self.doorOpen setStatusColor:btnColor];
                [self.doorStop setStatusColor:[UIColor greenColor]];
                [self.doorClose setStatusColor:btnColor];
                break;
            case DOORCLOSE:
                [self.doorOpen setStatusColor:btnColor];
                [self.doorStop setStatusColor:btnColor];
                [self.doorClose setStatusColor:[UIColor greenColor]];
                break;
            default:
                [self.doorOpen setStatusColor:btnColor];
                [self.doorStop setStatusColor:btnColor];
                [self.doorClose setStatusColor:btnColor];
                break;
        }

    }];
    }




/*************************************socket*********************************************
 /**
 *  进行socket连接
 *
 *  @param ip   ip地址
 *  @param port 端口号
 *
 *  @return
 */
-(BOOL)connectSocketIP:(NSString*)ip port:(UInt16)port
{
    //
    NSLog(@"正在连接设备");
    @try {
        self.asyncSocket=[[AsyncSocket alloc]initWithDelegate:self];
        NSError *err;
        if([self.asyncSocket connectToHost:ip onPort:port error:&err])
        {
            //连接成功
            return YES;
        }else
        {
            return NO;
        }
    } @catch (NSException *exception) {
        return NO;
        NSLog(@"%@",exception);
    } }
/**
 *  断开连接
 */
-(void)cutOffSocket
{
    
    [self.asyncSocket disconnect];//断开连接
    
}
/**
 *  初始化发送的数据
 *  并发送数据
 */
-( void)sendData:(Byte)type State:(Byte)state
{
    // NSData *sendData=[NSData alloc]initWithBytes:(nullable const void *) length:<#(NSUInteger)#>
    Byte sendBytes[7];
    sendBytes[0]=0xFF;
    sendBytes[1]=0xA5;
    sendBytes[2]=0x03;
    sendBytes[6]=0x5A;
    sendBytes[3]=type;
    sendBytes[4]=state;
    sendBytes[5]=(Byte)(3+sendBytes[3]+sendBytes[4]);
    NSData *sendData=[[NSData alloc]initWithBytes:sendBytes length:7];
    [self.asyncSocket writeData:sendData withTimeout:1 tag:1];
}

/**
 *  对接收到的数据进行格式化
 */
-(void)recData:(NSData*)data
{
    Byte *bytes=(Byte *)[data bytes];
    for (int i=0; i<[data length]; i++) {
        NSLog(@"%hhu",bytes[i]);
    }
    self.LAMPASTATE=(int)bytes[5];
    self.LAMPBSTATE=(int)bytes[4];
    self.DOORSTATE=(int)bytes[6];
    NSString *string=[NSString stringWithFormat:@"lampAstate:%d,lampBState:%d,DoorState:%d",_LAMPASTATE,_LAMPBSTATE,_DOORSTATE];
    self.textView.text=[NSString stringWithFormat:@"%@\r\n%@：%@,%@ .",self.textView.text,[self nowTime],_deviceIP,string];
    

}

-(void)heartbeats{
    NSLog(@"心跳检测");
      self.textView.text=[NSString stringWithFormat:@"%@\r\n%@： %@ heartbeat detection.",self.textView.text,[self nowTime],_deviceIP];
    [self sendData:9 State:0];
}
-(NSString*)nowTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    self.textView.text=[NSString stringWithFormat:@"%@\r\n%@： %@ disconnect.",self.textView.text,[self nowTime],_deviceIP];
      [self.textView scrollRectToVisible:CGRectMake(0, self.textView.contentSize.height-15, self.textView.contentSize.width, 10) animated:NO];
    NSLog(@"代理popover消失");
    [self cutOffSocket];
}
@end
