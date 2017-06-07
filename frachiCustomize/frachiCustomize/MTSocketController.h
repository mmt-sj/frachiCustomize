//
//  MTSocketController.h
//  梵祺展櫃
//
//  Created by hlen on 16/7/28.
//  Copyright © 2016年 mmt&sf. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AsyncSocket.h"

@interface MTSocketController : NSObject
@property(nonatomic,assign)int DOORSTATE;
@property(nonatomic,assign)int LAMPASTATE;
@property(nonatomic,assign)int LAMPBSTATE;

@property(nonatomic,strong)AsyncSocket* asyncSocket;
/**
 *  进行socket连接
 *
 *  @param ip   ip地址
 *  @param port 端口号
 */
-(BOOL)connectSocketIP:(NSString*)ip port:(UInt16)port;

/**
 *  初始化发送的数据
 *  并发送数据
 */
-( void)sendData:(Byte)type State:(Byte)state;

/**
 *  断开连接
 */
-(void)cutOffSocket;

-(void)recData:(NSData*)data;

-(void)heartbeats;

@end
