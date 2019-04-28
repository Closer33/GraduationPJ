//
//  QPRunManager.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/28.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPPausableMovingAnnotation.h"

typedef void (^TimeBlock)(NSString *timeStr);

NS_ASSUME_NONNULL_BEGIN

@interface QPRunManager : QPPausableMovingAnnotation

@property (nonatomic, copy) TimeBlock timeBlock;

- (void)startRun;
- (void)endRun;

@end

NS_ASSUME_NONNULL_END
