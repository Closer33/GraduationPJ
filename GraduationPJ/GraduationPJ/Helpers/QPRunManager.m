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

@property (nonatomic, strong) NSDate *startDate;

@end

@implementation QPRunManager

- (void)startRun {
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10;
    self.locationManager.locationTimeout = 2;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
//    [self.locationManager startUpdatingLocation];
    
    self.startDate = [NSDate date];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(clockTick) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)clockTick {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd:mm:ss"];
    NSDate *date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:self.startDate];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    NSLog(@"%@", timeStr);
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

@end
