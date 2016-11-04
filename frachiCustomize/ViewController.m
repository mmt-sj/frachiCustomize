//
//  ViewController.m
//  frachiCustomize
//
//  Created by mmt on 16/10/18.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "ViewController.h"
#import "mtButton.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property(nonatomic,strong)mtButton* lampABtn;
@property(nonatomic,strong)mtButton* lampOff;
@property(nonatomic,strong)mtButton* lampBBtn;
@property(nonatomic,strong)mtButton* doorOpen;
@property(nonatomic,strong)mtButton* doorStop;
@property(nonatomic,strong)mtButton* doorClose;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
