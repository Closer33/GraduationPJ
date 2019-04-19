//
//  QPAuthoritySettingViewController.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPAuthoritySettingViewController.h"
#import "QPPedometerManager.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "QPMainViewController.h"

typedef NS_ENUM(NSUInteger, QPAuthoritySettingType) {
    QPAuthoritySettingTypeMotion,   // 记步
    QPAuthoritySettingTypeLocation  // 定位
};

@interface QPAuthoritySettingViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

@property (nonatomic, assign) QPAuthoritySettingType type;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation QPAuthoritySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self setDataWithType:self.type];
}

- (void)setDataWithType:(QPAuthoritySettingType)type {
    switch (type) {
        case QPAuthoritySettingTypeMotion:
            self.bgImageView.backgroundColor = [UIColor yellowColor];
            self.titleLabel.text = @"步数轨迹全纪录";
            self.subTitleLabel.text = @"随时随地掌握步数\n请开启运动记步权限";
            [self.settingButton setTitle:@"设置记步权限" forState:UIControlStateNormal];
            break;
        case QPAuthoritySettingTypeLocation:
            self.bgImageView.backgroundColor = [UIColor greenColor];
            self.titleLabel.text = @"跑步健身有训练";
            self.subTitleLabel.text = @"开启定位权限\n为您准确记录走路跑步轨迹";
            [self.settingButton setTitle:@"设置定位权限" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (IBAction)settingButtonClick:(UIButton *)sender {
    switch (self.type) {
        case QPAuthoritySettingTypeMotion:
        {
            [[QPPedometerManager shareInstance] authorizeMotion:^(BOOL success) {
                if (success || [CMPedometer authorizationStatus] == CMAuthorizationStatusAuthorized) {
                    self.type = QPAuthoritySettingTypeLocation;
                    [self setDataWithType:self.type];
                } else {
                    [self showAlert];
                }
            }];
            break;
        }
        case QPAuthoritySettingTypeLocation:
            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
                [self.locationManager requestAlwaysAuthorization];
            } else {
                [self showAlert];
            }
            break;
        default:
            break;
    }
}

- (void)showAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权失败" message:@"请在设置中为趣跑设置对应权限，否则APP无法正常使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status ==  kCLAuthorizationStatusAuthorizedWhenInUse) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isNotFirstLaunch"];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[QPMainViewController alloc] init];
    }
}

- (void)dealloc
{
    NSLog(@"QPAuthoritySettingViewController");
}

@end
