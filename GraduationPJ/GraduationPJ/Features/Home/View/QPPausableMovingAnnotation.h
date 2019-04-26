//
//  QPPausableMovingAnnotation.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/26.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPPausableMovingAnnotation : MAAnimatedAnnotation

@property (nonatomic, assign) BOOL isPaused; //默认NO

@end

NS_ASSUME_NONNULL_END
