//
//  mtButton.m
//  梵祺展櫃
//
//  Created by hlen on 16/5/18.
//  Copyright © 2016年 mmt&sf. All rights reserved.
//

#import "mtButton.h"
#define animateDelay 0.15
#define defaultScale 0.9



@interface mtButton()
@property(nonatomic,strong)UIView *buttonStateView;

@end


@implementation mtButton
    //UIView *buttonStateView;


+(mtButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(ClickBlock)tempBlock{
    return  [mtButton buttonWithType:UIButtonTypeCustom frame:frame title:title titleColor:[UIColor whiteColor] backgroundColor:btnColor backgroundImage:nil andBlock:tempBlock];
}
+ (mtButton *)buttonWithType:(UIButtonType)type
                              frame:(CGRect)frame
                              title:(NSString *)title
                         titleColor:(UIColor *)color
                    backgroundColor:(UIColor *)backgroundColor
                    backgroundImage:(NSString *)image
                           andBlock:(ClickBlock)tempBlock
{
    mtButton * pushBtn = [mtButton buttonWithType:type];
    pushBtn.frame = frame;
    [pushBtn setTitle:title forState:UIControlStateNormal];
    [pushBtn setTitleColor:color forState:UIControlStateNormal];
    [pushBtn setBackgroundColor:backgroundColor];
    [pushBtn addTarget:pushBtn action:@selector(pressedEvent:) forControlEvents:UIControlEventTouchDown];
    [pushBtn addTarget:pushBtn action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [pushBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    //给按钮的block赋值
    pushBtn.clickBlock = tempBlock;
    pushBtn.titleLabel.numberOfLines=0;
    pushBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    return pushBtn;
}
+ (mtButton *)touchUpOutsideCancelButtonWithFrame:(CGRect)frame
                                           title:(NSString *)title
                                         andBlock:(ClickBlock)tempBlock{
    return [mtButton touchUpOutsideCancelButtonWithType:UIButtonTypeCustom frame:frame title:title titleColor:[UIColor whiteColor] backgroundColor:btnColor backgroundImage:nil andBlock:tempBlock];

}

+ (mtButton *)touchUpOutsideCancelButtonWithType:(UIButtonType)type
                                                  frame:(CGRect)frame
                                                  title:(NSString *)title
                                             titleColor:(UIColor *)color
                                        backgroundColor:(UIColor *)backgroundColor
                                        backgroundImage:(NSString *)image
                                               andBlock:(ClickBlock)tempBlock
{
    mtButton * pushBtn = [mtButton buttonWithType:type];
    pushBtn.frame = frame;
    [pushBtn setTitle:title forState:UIControlStateNormal];
    [pushBtn.titleLabel setNumberOfLines:3];
    pushBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    pushBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [pushBtn setTitleColor:color forState:UIControlStateNormal];
    [pushBtn setBackgroundColor:backgroundColor];
    [pushBtn addTarget:pushBtn action:@selector(pressedEvent:) forControlEvents:UIControlEventTouchDown];
    [pushBtn addTarget:pushBtn action:@selector(cancelEvent:) forControlEvents:UIControlEventTouchUpOutside];
    [pushBtn addTarget:pushBtn action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpInside];
    [pushBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    pushBtn.layer.cornerRadius=15;
    pushBtn.layer.masksToBounds=YES;
    

    //给按钮的block赋值
    pushBtn.clickBlock = tempBlock;
    
    return pushBtn;
}
-(void)setStatusColor:(UIColor* )color{
    self.status.backgroundColor=color;
}
-(void)addStatusView{
    self.status=[[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-5)/2-2, self.frame.size.height-20, 10, 10)];
    self.status.layer.masksToBounds=YES;
    self.status.layer.cornerRadius=5;
    [self addSubview:_status];
}
//按钮的压下事件 按钮缩小
- (void)pressedEvent:(mtButton *)btn
{
    //缩放比例必须大于0，且小于等于1
    CGFloat scale = (_buttonScale && _buttonScale <=1.0) ? _buttonScale : defaultScale;
    
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}

//点击手势拖出按钮frame区域松开，响应取消
- (void)cancelEvent:(mtButton *)btn
{
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}
//按钮的松开事件 按钮复原 执行响应
- (void)unpressedEvent:(mtButton *)btn
{
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        //执行动作响应
        if (self.clickBlock) {
            self.clickBlock();
        }
    }];
}

//此方法重写为空，可以将image按钮的点击灰色去掉
//- (void)setHighlighted:(BOOL)highlighted
//{
//
//}

@end
