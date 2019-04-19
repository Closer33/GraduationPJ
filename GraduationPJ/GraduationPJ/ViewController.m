//
//  ViewController.m
//  GraduationPJ
//
//  Created by yinquan on 2019/4/13.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface ViewController ()<TencentSessionDelegate> {
    MAMapView *_mapView;
    TencentOAuth *_tencentOAuth;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化地图
//    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_mapView];
}

- (void)tencentDidLogin {
    NSLog(@"登录成功");
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        NSLog(@"取消登录");
    }
}

- (void)tencentDidNotNetWork {
    NSLog(@"tencentDidNotNetWork");
}


@end
