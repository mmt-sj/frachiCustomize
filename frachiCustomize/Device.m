//
//  Device.m
//  frachiCustomize
//
//  Created by mmt on 16/11/1.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "Device.h"

@implementation Device
-(NSInteger)addDevice:(int)ID ColorID:(int)colorID IP:(NSString*)ip Port:(NSString*)port Type:(int)type Remark:(NSString*)remark{
    int static status=0;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        //Device *device=[[Device alloc]init];
        self.ID=ID;
        self.colorID=colorID;
        self.ip=ip;
        self.port=port;
        self.type=type;
        self.remark=remark;
        if(!([self selectDevice:ID])){
            
            //提交事務
            [realm addObject:self];
            NSLog(@"準備提交事務");
            [realm commitWriteTransaction];
            NSLog(@"完成");
            status=1;
           
        }else{
            NSLog(@"%d已經存在",ID);
            status=0;
            
        }
    }];
    return status;
}
//oldID newID
-(NSInteger)editDeviceNewID:(int)newID OldID:(int)oldID ColorID:(int)colorID IP:(NSString*)ip Port:(NSString*)port Type:(int)type Remark:(NSString*)remark{
    static int status;
    NSLog(@"newID is %d,oldID is %d",newID,oldID);
    //首先判断新的id是否和旧的id一样 如果一样 不进行id验证 进行更新 如果不一样进行id验证
    if(newID==oldID){
        RLMRealm *realm=[RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            RLMResults *result=[Device objectsWhere:[NSString stringWithFormat:@"ID=%d",oldID]];
            Device *dev=[result objectAtIndex:0];
            dev.ID=newID;
            dev.colorID=colorID;
            dev.ip=ip;
            dev.port=port;
            dev.type=type;
            dev.remark=remark;
            [realm commitWriteTransaction];
        }];
        status=1;
    }else{
        if(!([self selectDevice:newID])){
            RLMRealm *realm=[RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                RLMResults *result=[Device objectsWhere:[NSString stringWithFormat:@"ID=%d",oldID]];
                Device *dev=[result objectAtIndex:0];
                dev.ID=newID;
                dev.colorID=colorID;
                dev.ip=ip;
                dev.port=port;
                dev.type=type;
                dev.remark=remark;
                [realm commitWriteTransaction];
                 status=1;
            }];
           
        }else{
            status=0;
        }

    }
       return status;
 }
-(NSMutableArray*)selectAllDevice{
    RLMResults *result=[Device allObjects];
    NSMutableArray *muArray=[[NSMutableArray alloc]init];
    for (Device* temp in [result sortedResultsUsingProperty:@"ID" ascending:YES]) {
        [muArray addObject:temp];
    }
    return muArray;
}
-(NSInteger)selectDevice:(int)ID{
    RLMResults *result=[Device objectsWhere:[NSString stringWithFormat:@"ID=%d",ID]];
    if(result.count>0){
        return 1;
    }else{
        return 0;
    }
}
-(NSInteger)deleteDevice:(int)ID{
    static int status=0;
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        RLMResults *result=[Device objectsWhere:[NSString stringWithFormat:@"ID=%d",ID]];
        [realm deleteObject:result.firstObject];
        [realm commitWriteTransaction];
        status=1;
    }];
    return  status;
}
-(NSInteger)autoGetNumber{
    NSInteger temp=0;
    do {
        temp++;
    } while ([self selectDevice:(int)temp]);
    return temp;
}
-(Device*)selectOneDevice:(int)ID{
    RLMResults *result=[Device objectsWhere:[NSString stringWithFormat:@"ID=%d",ID]];
    Device *device=result.firstObject;
    return device;
}
@end
