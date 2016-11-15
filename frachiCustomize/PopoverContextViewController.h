//
//  PopoverContextViewController.h
//  frachiCustomize
//
//  Created by mmt on 16/11/4.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverContextViewController : UIViewController<UIPopoverControllerDelegate>
@property(nonatomic,assign)int type;
@property(nonatomic,assign)int deviceID;

@property(nonatomic,assign)UITextView *textView;
@end
