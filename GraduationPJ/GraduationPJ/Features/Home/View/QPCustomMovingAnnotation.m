//
//  QPCustomMovingAnnotation.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/26.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPCustomMovingAnnotation.h"

@implementation QPCustomMovingAnnotation

- (void)step:(CGFloat)timeDelta {
    [super step:timeDelta];
    
    if(self.stepCallback) {
        self.stepCallback();
    }
}

@end
