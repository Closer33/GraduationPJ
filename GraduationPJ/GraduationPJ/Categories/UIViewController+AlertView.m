//
//  UIViewController+AlertView.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/25.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "UIViewController+AlertView.h"

@implementation UIViewController (AlertView)

- (void)showAlertViewWithType:(QPAlertViewType)type {
    UIAlertView *alertView = nil;
    switch (type) {
        case QPAlertViewTypeConnectFiled:
            alertView = [[UIAlertView alloc] initWithTitle:@"连接失败" message:@"服务器目前不可用，请联系管理员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            break;
        case QPAlertViewTypeRoomIdError:
            alertView = [[UIAlertView alloc] initWithTitle:@"加入房间失败" message:@"请输入正确的房间号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            break;
        case QPAlertViewTypeRoomDisappear:
            alertView = [[UIAlertView alloc] initWithTitle:@"房间消失在异次元了" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            break;
        default:
            break;
    }
    [alertView show];
}

@end
