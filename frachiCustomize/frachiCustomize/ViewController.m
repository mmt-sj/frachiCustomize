//
//  ViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/10/18.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "ViewController.h"
#import "mtButton.h"
#import "PopoverContextViewController.h"
#import "Device.h"
#import "XHToast.h"

#import "SWRevealViewController.h"

@interface ViewController ()<UIPopoverControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property(nonatomic,strong)mtButton* lampABtn;
@property(nonatomic,strong)mtButton* lampOff;
@property(nonatomic,strong)mtButton* lampBBtn;
@property(nonatomic,strong)mtButton* doorOpen;
@property(nonatomic,strong)mtButton* doorStop;
@property(nonatomic,strong)mtButton* doorClose;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property(nonatomic,strong)UIPopoverController* popverController;

@end

@implementation ViewController{
    NSMutableArray *_allButton;
    Device *_device;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLeftMenu];
    self.view.backgroundColor=[UIColor whiteColor];
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    self.textView.editable=NO;
    // Do any additional setup after loading the view, typically from a nib.
    _allButton=[[NSMutableArray alloc]init];
    _device=[[Device alloc]init];
    [self addView];
    NSArray * array=[self.view subviews];
    for (UIView *temp in array) {
        if([temp isKindOfClass:[UIButton class]]){
            //是button
            [_allButton addObject:temp];
        }
    }
    for (UIButton *btns in _allButton) {
        if(btns.tag<100&&btns.tag>0){
            [btns addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initLeftMenu
{
    //注册该页面可以执行滑动切换
    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    // 注册该页面可以执行点击切换
   // [leftBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn addTarget:revealController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)initPopover:(id)sender{
    UIButton *btn=(UIButton *)sender;
    PopoverContextViewController *popoverView=[[PopoverContextViewController alloc]init];
    if(!([_device selectDevice:(int)btn.tag])){
        [XHToast showCenterWithText:@"沒有設置相對應的硬件設備！"];
        return;
    }
    _device=[_device selectOneDevice:(int)btn.tag];
    popoverView.type=_device.type;
    popoverView.deviceID=_device.ID;
    
    CGFloat popoverHeight=400;
    if(_device.type!=0){
        popoverHeight=300;
    }
    self.popverController=[[UIPopoverController alloc]initWithContentViewController:popoverView];
    popoverView.textView=self.textView;
    self.popverController.delegate=popoverView;
    [self.popverController setPopoverContentSize:CGSizeMake(400, popoverHeight) animated:YES];
    [self.popverController presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
-(void)mapAction:(id)sender{
    NSLog(@"sender tag is %d",(int)[sender tag]);
    //xianshi
    [self initPopover:sender];
}
-(void)addView{
    //6個按鈕 每個那妞的寬度130
    CGFloat btnW=120;
    CGFloat margin=(self.bottomView.frame.size.width-btnW*6)/6;

    CGFloat btnH=80;
    self.lampABtn=[mtButton buttonWithFrame:CGRectMake(margin/2, 20, btnW, btnH) title:@"燈 A\r\nLAMP A" andBlock:^{
        
    }];
    self.lampABtn.layer.masksToBounds=YES;
    self.lampABtn.layer.cornerRadius=10;
    [self.bottomView addSubview:self.lampABtn];
    //關燈
    self.lampOff=[mtButton buttonWithFrame:CGRectMake(margin/2+btnW+margin, 20, btnW, btnH) title:@"燈 關\r\nLAMP OFF" andBlock:^{
        
    }];
    self.lampOff.layer.masksToBounds=YES;
    self.lampOff.layer.cornerRadius=10;
    [self.bottomView addSubview:self.lampOff];
    //燈B
    self.lampBBtn=[mtButton buttonWithFrame:CGRectMake(margin/2+btnW*2+margin*2, 20, btnW, btnH) title:@"燈 B\r\nLAMP B" andBlock:^{
        
    }];
    self.lampBBtn.layer.masksToBounds=YES;
    self.lampBBtn.layer.cornerRadius=10;
    [self.bottomView addSubview:self.lampBBtn];
    //門開
    self.doorOpen=[mtButton buttonWithFrame:CGRectMake(margin/2+btnW*3+margin*3, 20, btnW, btnH) title:@"門 開\r\nOPEN" andBlock:^{
        
    }];
    self.doorOpen.layer.masksToBounds=YES;
    self.doorOpen.layer.cornerRadius=10;
    [self.bottomView addSubview:self.doorOpen];
    //門停
    self.doorStop=[mtButton buttonWithFrame:CGRectMake(margin/2+btnW*4+margin*4, 20, btnW, btnH) title:@"門 停\r\nSTOP" andBlock:^{
        
    }];
    self.doorStop.layer.masksToBounds=YES;
    self.doorStop.layer.cornerRadius=10;
    [self.bottomView addSubview:self.doorStop];
    //門關
    self.doorClose=[mtButton buttonWithFrame:CGRectMake(margin/2+btnW*5+margin*5, 20, btnW, btnH) title:@"門 關\r\nCLOSE" andBlock:^{
        
    }];
    self.doorClose.layer.masksToBounds=YES;
    self.doorClose.layer.cornerRadius=10;
    [self.bottomView addSubview:self.doorClose];
}

@end
