//
//  QPNetworkManager.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/22.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPNetworkManager.h"

@implementation QPNetworkManager

+ (instancetype)shareInstance {
    static QPNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QPNetworkManager alloc] init];
        [instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return instance;
}

@end
