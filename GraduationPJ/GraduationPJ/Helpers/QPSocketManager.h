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
typedef void(^closeBlock)(void);

@interface QPSocketManager : NSObject

@property (nonatomic, copy) successBlock successBlock;
@property (nonatomic, copy) messageBlock messageBlock;
@property (nonatomic, copy) closeBlock closeBlock;

+ (instancetype)shareInstance;

- (void)connectWithProtocol:(NSArray *)protocols;
- (void)sendMessage:(NSString *)message;
- (void)close;

@end
