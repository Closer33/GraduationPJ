//
//  QPPedometerManager.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPPedometerManager : NSObject

+ (instancetype)shareInstance;

- (void)authorizeMotion:(void(^)(BOOL success))compltion;

@end

NS_ASSUME_NONNULL_END
