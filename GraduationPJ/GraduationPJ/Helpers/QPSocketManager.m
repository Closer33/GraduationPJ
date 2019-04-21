//
//  QPSocketManager.m
//  GraduationPJ
//
//  Created by yinquan on 2019/4/21.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPSocketManager.h"
#import <SocketRocket.h>

@interface QPSocketManager ()<SRWebSocketDelegate>

@property (nonatomic,strong) SRWebSocket *webSocket;

@end

@implementation QPSocketManager

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QPSocketManager alloc] init];
    });
    return instance;
}

- (void)connectWithProtocol:(NSString *)protocol {
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:8181/echo"] protocols:@[protocol]];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

- (void)close {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
}

//成功连接
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {

}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self close];
}

@end
