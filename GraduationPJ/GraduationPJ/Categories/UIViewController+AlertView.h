//
//  UIViewController+AlertView.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/25.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QPAlertViewType) {
    QPAlertViewTypeConnectFiled,   // 连接失败
    QPAlertViewTypeRoomIdError,  // 房间号错误
    QPAlertViewTypeRoomDisappear  // 房间消失
};

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AlertView)

- (void)showAlertViewWithType:(QPAlertViewType)type;

@end

NS_ASSUME_NONNULL_END
