//
//  QPSocketManager.h
//  GraduationPJ
//
//  Created by yinquan on 2019/4/21.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(BOOL);
typedef void(^messageBlock)(NSDictionary *);

@interface QPSocketManager : NSObject

@property (nonatomic, copy) successBlock successBlock;
@property (nonatomic, copy) messageBlock messageBlock;

+ (instancetype)shareInstance;

- (void)connectWithProtocol:(NSArray *)protocols;
- (void)sendMessage:(NSString *)message;
- (void)close;

@end
