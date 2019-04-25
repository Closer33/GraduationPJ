//
//  QPSocketManager.m
//  GraduationPJ
//
//  Created by yinquan on 2019/4/21.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPSocketManager.h"
#import <SocketRocket.h>

typedef void(^isSuccessBlock)(BOOL);

@interface QPSocketManager ()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;
@property (nonatomic, assign) BOOL isJoin;

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

- (void)connectWithProtocol:(NSArray *)protocols {
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:8181/api/v1/websockt"] protocols:protocols];
    self.webSocket.delegate = self;
    [self.webSocket open];
    
    if ([protocols[0] isEqual:@"create"]) {
        self.isJoin = NO;
    } else {
        self.isJoin = YES;
    }
}

- (void)sendMessage:(NSString *)message {
    if (self.webSocket) {
        [self.webSocket send:message];
    }
}

- (void)close {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    if (self.successBlock) {
        self.successBlock(NO);
    }
}

//成功连接
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    if (self.successBlock) {
        self.successBlock(YES);
    }
    if (self.isJoin) {
        [self.webSocket send:@"join"];
    } else {
        [self.webSocket send:@"create"];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    if (self.messageBlock) {
        NSDictionary *dict = [self dictionaryWithJsonString:message];
        self.messageBlock(dict);
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"webServer close");
    if (self.closeBlock) {
        self.closeBlock();
    }
    [self close];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",jsonString);
        return nil;
    }
    return dic;
}

@end
