//
//  User.m
//  frachiCustomize
//
//  Created by mmt on 16/11/1.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import "User.h"

@implementation User
-(void)addUser:(NSString *) name Password:(NSString *)password{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        User *user=[[User alloc]init];
        user.userID=name;
        user.password=password;
        if(!([self selectUser:name])){
            [realm addObject:user];
            //提交事務
            NSLog(@"準備提交事務");
            [realm commitWriteTransaction];
            NSLog(@"完成");
        }else{
            NSLog(@"%@已經存在",name);
        }
       
    }];
}
-(NSInteger)selectUser:(NSString*)name{
    RLMResults *user=[User objectsWhere:[NSString stringWithFormat:@"userID='%@'",name]];
    if(user.count>0){
        return 1;//存在
    }else{
        return 0;//不存在
    }
    
}
-(NSInteger)selectUser:(NSString*)name Password:(NSString*)password{
    RLMResults *user=[User objectsWhere:[NSString stringWithFormat:@"userID='%@' AND password='%@'",name,password]];
    if(user.count>0){
        return 1;//存在
    }else{
        return 0;//不存在
    }

}
-(NSInteger)editPassword:(NSString*)password Name:(NSString*)name{
    
    RLMRealm *realm=[RLMRealm defaultRealm];
    static int status=0;
    [realm transactionWithBlock:^{
        RLMResults *result=[User objectsWhere:[NSString stringWithFormat:@"userID='%@'",name]];
        User *user=result.firstObject;
        user.password=password;
        [realm commitWriteTransaction];
        status=1;
    }];
    return  status;
}
@end
