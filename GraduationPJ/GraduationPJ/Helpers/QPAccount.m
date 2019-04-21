//
//  QPAccount.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPAccount.h"

@interface QPAccessInfo : NSObject<NSCoding>

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSDate *expirationDate;

@end

@implementation QPAccessInfo

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.openId forKey:@"openId"];
    [aCoder encodeObject:self.expirationDate forKey:@"expirationDate"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.openId = [aDecoder decodeObjectForKey:@"openId"];
        self.expirationDate = [aDecoder decodeObjectForKey:@"expirationDate"];
    }
    return self;
}

@end

@implementation QPAccount

+ (void)saveAccessInfoWithAccessToken:(NSString *)accessToken
                       expirationDate:(NSDate *)expirationDate
                               openId:(NSString *)openId {
    QPAccessInfo *accessInfo = [QPAccessInfo new];
    accessInfo.accessToken = accessToken;
    accessInfo.expirationDate = expirationDate;
    accessInfo.openId = openId;
    [NSKeyedArchiver archiveRootObject:accessInfo toFile:[self getFilePathWitName:@"accessInfo"]];
}

+ (void)saveUserInfoWithDic:(NSDictionary *)dic {
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
}

+ (NSDictionary *)getUserInfo {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"userInfo"];
}

+ (BOOL)isLogin {
    QPAccessInfo *accessInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePathWitName:@"accessInfo"]];
    if (accessInfo && accessInfo.accessToken && [self isExpirationWithDate:accessInfo.expirationDate]) {
        return YES;
    }
    return NO;
}

+ (NSString *)getFilePathWitName:(NSString *)name {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [path stringByAppendingPathComponent:name];
}

+ (BOOL)isExpirationWithDate:(NSDate *)date {
    NSComparisonResult result = [date compare:[NSDate date]];
    switch (result) {
        case NSOrderedAscending:
            return NO;
        case NSOrderedSame:
        case NSOrderedDescending:
            return YES;
        default:
            break;
    }
}

@end

//Printing description of response->_jsonResponse:
//{
//    city = "\U6b66\U6c49";
//    constellation = "";
//    figureurl = "http://qzapp.qlogo.cn/qzapp/1108733927/0D24B7A7A6107314C640DAF477327B1D/30";
//    "figureurl_1" = "http://qzapp.qlogo.cn/qzapp/1108733927/0D24B7A7A6107314C640DAF477327B1D/50";
//    "figureurl_2" = "http://qzapp.qlogo.cn/qzapp/1108733927/0D24B7A7A6107314C640DAF477327B1D/100";
//    "figureurl_qq" = "http://thirdqq.qlogo.cn/g?b=oidb&k=Y90RpMNqCLQg7otejtY5xA&s=140";
//    "figureurl_qq_1" = "http://thirdqq.qlogo.cn/g?b=oidb&k=Y90RpMNqCLQg7otejtY5xA&s=40";
//    "figureurl_qq_2" = "http://thirdqq.qlogo.cn/g?b=oidb&k=Y90RpMNqCLQg7otejtY5xA&s=100";
//    "figureurl_type" = 1;
//    gender = "\U7537";
//    "is_lost" = 0;
//    "is_yellow_vip" = 0;
//    "is_yellow_year_vip" = 0;
//    level = 0;
//    msg = "";
//    nickname = Closer;
//    province = "\U6e56\U5317";
//    ret = 0;
//    vip = 0;
//    year = 1996;
//    "yellow_vip_level" = 0;
//}
