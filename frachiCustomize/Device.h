//
//  Device.h
//  frachiCustomize
//
//  Created by mmt on 16/11/1.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
@interface Device : RLMObject
@property(nonatomic,assign) int ID;//編號
@property(nonatomic,assign)int colorID;//顏色編號
@property(nonatomic,copy)NSString* ip;//地址
@property(nonatomic,copy)NSString* port;//端口
@property(nonatomic,assign)int type;//類型
@property(nonatomic,copy)NSString* remark;//備註

-(NSInteger)addDevice:(int)ID ColorID:(int)colorID IP:(NSString*)ip Port:(NSString*)port Type:(int)type Remark:(NSString*)remark;
-(NSInteger)editDeviceNewID:(int)newID OldID:(int)oldID ColorID:(int)colorID IP:(NSString*)ip Port:(NSString*)port Type:(int)type Remark:(NSString*)remark;
-(NSMutableArray*)selectAllDevice;
-(NSInteger)deleteDevice:(int)ID;
-(Device*)selectOneDevice:(int)ID;
-(NSInteger)autoGetNumber;
-(NSInteger)selectDevice:(int)ID;
@end
