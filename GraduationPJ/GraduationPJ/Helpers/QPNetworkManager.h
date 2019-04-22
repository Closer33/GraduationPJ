//
//  QPNetworkManager.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/22.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPNetworkManager : AFHTTPSessionManager

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
