//
//  QPRoomModel.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

@interface QPUserInfo : NSObject

@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *figureurl;

@end

NS_ASSUME_NONNULL_BEGIN

@interface QPRoomModel : NSObject

@property (nonatomic, assign) NSNumber *roomId;
@property (nonatomic, strong) NSArray *userInfos;

@end

NS_ASSUME_NONNULL_END
