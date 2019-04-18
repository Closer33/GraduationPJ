//
//  QPPedometerManager.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPPedometerManager.h"
#import <CoreMotion/CoreMotion.h>

@interface QPPedometerManager()

@property(nonatomic,strong) CMPedometer *pedometer;

@end

@implementation QPPedometerManager

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QPPedometerManager alloc] init];
    });
    return instance;
}

- (void)authorizeMotion:(void(^)(BOOL success))compltion {
    if (![CMPedometer isStepCountingAvailable]) {
        if (compltion) {
            compltion(NO);
        }
    }
    self.pedometer = [[CMPedometer alloc] init];
    NSDate *today = [NSDate date];
    [self.pedometer queryPedometerDataFromDate:[self zeroDate] toDate:today withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)  {
                compltion(NO);
            } else {
                compltion(YES);
            }
        });
    }];
}

- (NSDate *)zeroDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

@end
