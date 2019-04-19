//
//  UIView+Frame.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nonatomic,getter = y,setter = setY:) float top;
@property (nonatomic,getter = x,setter = setX:) float left;
@property (nonatomic) float bottom;
@property (nonatomic) float right;
@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@end

NS_ASSUME_NONNULL_END
