//
//  QPAccount.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPAccount : NSObject

+ (void)saveAccessInfoWithAccessToken:(NSString *)accessToken
                       expirationDate:(NSDate *)expirationDate
                               openId:(NSString *)openId;
+ (void)saveUserInfoWithDic:(NSDictionary *)dic;
+ (BOOL)isLogin;

@end

NS_ASSUME_NONNULL_END
