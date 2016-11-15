//
//  mtButton.h
//  梵祺展櫃
//
//  Created by hlen on 16/5/18.
//  Copyright © 2016年 mmt&sf. All rights reserved.
//

#import <UIKit/UIKit.h>
#define btnColor [UIColor colorWithRed:76/255.0 green:71/255.0 blue:68/255.0 alpha:1.0]
typedef void(^ClickBlock)();

@interface mtButton : UIButton

@property (nonatomic, copy) ClickBlock clickBlock;
@property (nonatomic, assign) CGFloat buttonScale;//缩小的比率，小于=1.0,大于0.0

@property(nonatomic,strong)UIView* status;

//@property(nonatomic,assign) BOOL ButtonState;
//常规方法
+(mtButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(ClickBlock)tempBlock;
+ (mtButton *)buttonWithType:(UIButtonType)type
                              frame:(CGRect)frame
                              title:(NSString *)title
                         titleColor:(UIColor *)color
                    backgroundColor:(UIColor *)backgroundColor
                    backgroundImage:(NSString *)image
                           andBlock:(ClickBlock)tempBlock
               ;

//此方法初始化的按钮，点击后，在按钮frame内部松手，执行响应，拖出frame区域松手，响应取消
+ (mtButton *)touchUpOutsideCancelButtonWithType:(UIButtonType)type
                                                  frame:(CGRect)frame
                                                  title:(NSString *)title
                                             titleColor:(UIColor *)color
                                        backgroundColor:(UIColor *)backgroundColor
                                        backgroundImage:(NSString *)image
                                               andBlock:(ClickBlock)tempBlock
                                                ;

+ (mtButton *)touchUpOutsideCancelButtonWithFrame:(CGRect)frame
                                            title:(NSString *)title
                                         andBlock:(ClickBlock)tempBlock;

-(void)setStatusColor:(UIColor*)color;
-(void)addStatusView;
@end
