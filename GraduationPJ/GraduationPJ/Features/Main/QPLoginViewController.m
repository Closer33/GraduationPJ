//
//  QPLoginViewController.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPLoginViewController.h"
#import "QPMainViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "QPAccount.h"
#import "QPNetworkManager.h"

@interface QPLoginViewController ()<TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end

@implementation QPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginButtonClick:(id)sender {
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1108733927" andDelegate:self];
    _tencentOAuth.authShareType = AuthShareType_TIM;
    NSArray *permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, kOPEN_PERMISSION_GET_USER_INFO, nil];
    [_tencentOAuth authorize:permissions];
}

- (void)tencentDidLogin {
    NSLog(@"登录完成");
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]) {
        [QPAccount saveAccessInfoWithAccessToken:_tencentOAuth.accessToken expirationDate:_tencentOAuth.expirationDate openId:_tencentOAuth.openId];
        [_tencentOAuth getUserInfo];
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    NSLog(@"登录失败");
}

- (void)tencentDidNotNetWork {
    NSLog(@"登录失败");
}

- (void)getUserInfoResponse:(APIResponse *)response {
    if (!response.errorMsg) {
        [QPAccount saveUserInfoWithDic:response.jsonResponse];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[QPMainViewController alloc] init];
        
        // 将用户信息发送到服务器
        [[QPNetworkManager shareInstance] GET:@"http://localhost:8181/api/v1/oauth" parameters:response.jsonResponse progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        } failure:nil];
    }
}

- (void)dealloc {
    NSLog(@"QPLoginViewController");
}

@end
