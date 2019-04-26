//
//  QPCustomMovingAnnotation.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/26.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPPausableMovingAnnotation.h"

typedef void (^CustomMovingAnnotationCallback)();

NS_ASSUME_NONNULL_BEGIN

@interface QPCustomMovingAnnotation : QPPausableMovingAnnotation

@property (nonatomic, copy) CustomMovingAnnotationCallback stepCallback;

@end

NS_ASSUME_NONNULL_END
