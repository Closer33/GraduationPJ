//
//  QPPausableMovingAnnotation.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/26.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPPausableMovingAnnotation.h"

@implementation QPPausableMovingAnnotation

- (void)step:(CGFloat)timeDelta {
    if(self.isPaused) {
        return;
    }
    
    [super step:timeDelta];
}

@end
