//
//  QPHealthKitManager.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPHealthKitManager.h"
#import <HealthKit/HealthKit.h>

@interface QPHealthKitManager()

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation QPHealthKitManager

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QPHealthKitManager alloc] init];
    });
    return instance;
}

- (void)authorizeHealth:(void (^)(BOOL success, NSError *error))compltion {
    if (![HKHealthStore isHealthDataAvailable]) {
        if (compltion) {
            compltion(NO, nil);
        }
    }
    self.healthStore = [[HKHealthStore alloc] init];
    [self.healthStore requestAuthorizationToShareTypes:[self dataTypesToWrite] readTypes:[self dataTypesRead] completion:^(BOOL success, NSError * _Nullable error) {
        if (compltion) {
            compltion(NO, error);
        }
    }];
}

- (NSSet *)dataTypesToWrite
{
    HKQuantityType *temperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    return [NSSet setWithObjects:temperatureType, activeEnergyType,nil];
}

- (NSSet *)dataTypesRead
{
    HKQuantityType *temperatureType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distance = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    return [NSSet setWithObjects:temperatureType, stepCountType, distance, activeEnergyType,nil];
}

@end
