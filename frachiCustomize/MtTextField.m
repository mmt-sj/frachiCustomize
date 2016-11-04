//
//  MtTextField.m
//  frachiCustomize
//
//  Created by mmt on 16/11/3.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "MtTextField.h"

@implementation MtTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame Name:(NSString*)name
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height = frame.size.height;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 50,30)];
        leftView.backgroundColor = [UIColor colorWithRed:132/255.0f green:214/255.0f blue:219/255.0f alpha:1.0f];
        
//        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(height/4, height/4, 50, height/2)];
        label.text=name;
//        icon.frame = CGRectMake(height / 4, height / 4, height / 2, height / 2);
//        [leftView addSubview:icon];
        [leftView addSubview:label];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:leftView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = leftView.bounds;
        maskLayer.path = maskPath.CGPath;
        leftView.layer.mask = maskLayer;
        self.borderStyle=UITextBorderStyleRoundedRect;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}
@end
