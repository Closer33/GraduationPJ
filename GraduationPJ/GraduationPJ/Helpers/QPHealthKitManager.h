//
//  QPHealthKitManager.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPHealthKitManager : NSObject

+ (instancetype)shareInstance;

- (void)authorizeHealth:(void(^)(BOOL success, NSError *error))compltion;

@end

NS_ASSUME_NONNULL_END
