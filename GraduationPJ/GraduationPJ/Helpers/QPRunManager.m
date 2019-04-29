//
//  QPRunManager.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/28.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPRunManager.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface QPRunManager()<AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, assign) CLLocation *lastLocation;
@property (nonatomic, strong) NSDate *lastLocatedDate;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSUInteger startTime;
@end

@implementation QPRunManager

- (void)startRun {
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10;
    self.locationManager.locationTimeout = 2;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
//    [self.locationManager startUpdatingLocation];
    
    self.startTime = (NSUInteger)CFAbsoluteTimeGetCurrent();
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(clockTick) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)clockTick {

    NSUInteger currentTime = (NSUInteger)CFAbsoluteTimeGetCurrent();
    NSUInteger elapsedTime = currentTime - self.startTime;
    
    NSString *timeStr = [self timeStrFromUseTime:elapsedTime];
    if (self.timeBlock) {
        self.timeBlock(timeStr);
    }
}

- (void)endRun {
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    if (!self.lastLocation) {
        self.lastLocation = location;
        self.lastLocatedDate = [NSDate date];
        return;
    }
    
    double distance = [location distanceFromLocation:self.lastLocation];
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.lastLocatedDate];
    double speed = distance / time;
}

#pragma mark - Time Helper

- (NSString *)timeStrFromUseTime:(NSInteger)useTime
{
    // 将秒转换成“00:00:00”的格式来显示
    NSInteger secPerHour = 60 * 60;
    NSInteger hour = useTime / secPerHour;
    NSInteger min = (useTime % secPerHour) / 60;
    NSInteger sec = (useTime % secPerHour) % 60;
    
    NSString *hourStr = (hour >= 10) ? [NSString stringWithFormat:@"%@", @(hour)] : [NSString stringWithFormat:@"0%@", @(hour)];
    NSString *minStr = (min >= 10) ? [NSString stringWithFormat:@"%@", @(min)] : [NSString stringWithFormat:@"0%@", @(min)];
    NSString *secStr = (sec >= 10) ? [NSString stringWithFormat:@"%@", @(sec)] : [NSString stringWithFormat:@"0%@", @(sec)];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@:%@:%@", hourStr, minStr, secStr];
    return timeStr;
}

@end
