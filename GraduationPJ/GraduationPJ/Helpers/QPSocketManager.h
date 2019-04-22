//
//  QPSocketManager.h
//  GraduationPJ
//
//  Created by yinquan on 2019/4/21.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPSocketManager : NSObject

+ (instancetype)shareInstance;

- (void)connectWithProtocol:(NSString *)protocol;
- (void)close;

@end
