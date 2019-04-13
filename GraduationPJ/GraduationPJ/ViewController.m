//
//  ViewController.m
//  GraduationPJ
//
//  Created by yinquan on 2019/4/13.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface ViewController () {
    MAMapView *_mapView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
