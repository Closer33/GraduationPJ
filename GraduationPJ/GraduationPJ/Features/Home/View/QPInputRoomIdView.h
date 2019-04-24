//
//  QPInputRoomIdView.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^complete)(NSString *);

@interface QPInputRoomIdView : UIView

@property (nonatomic, copy) complete completeBlcok;


@end

NS_ASSUME_NONNULL_END
