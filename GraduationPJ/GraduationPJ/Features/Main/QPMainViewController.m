//
//  QPMainViewController.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/18.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPMainViewController.h"
#import "QPLoginViewController.h"
#import "QPTabBarController.h"
#import "QPAccount.h"

@interface QPMainViewController ()

@end

@implementation QPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *childVC = nil;
    if ([QPAccount isLogin]) {
        childVC = [[UIStoryboard storyboardWithName:@"QPTabBarController" bundle:nil] instantiateInitialViewController];
    } else {
        childVC = [[QPLoginViewController alloc] init];
    }
    [self addChildViewController:childVC];
    childVC.view.frame = self.view.bounds;
    [self.view addSubview:childVC.view];
}


@end
