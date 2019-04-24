//
//  QPRoomView.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^closeRoom)(NSString *);

NS_ASSUME_NONNULL_BEGIN

@interface QPRoomView : UIView

@property (nonatomic, strong) closeRoom clseRoomBlock;

- (void)removeFromWindow;
- (void)loadInitDataWithRoomId:(NSString *)roomId;
- (void)loadDataWithDic:(NSDictionary *)dic isOwner:(BOOL)isOwner;

@end

NS_ASSUME_NONNULL_END
