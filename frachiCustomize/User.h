//
//  User.h
//  frachiCustomize
//
//  Created by mmt on 16/11/1.
//  Copyright © 2016年 mmt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
@interface User : RLMObject

@property(nonatomic,copy) NSString* userID;//id
@property(nonatomic,copy) NSString* password;//密码

-(void)addUser:(NSString *) name Password:(NSString *)password;
-(NSInteger)selectUser:(NSString*)name Password:(NSString*)password;
-(NSInteger)editPassword:(NSString*)password Name:(NSString*)name;
@end
