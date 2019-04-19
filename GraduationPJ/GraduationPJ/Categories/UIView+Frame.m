//
//  UIView+Frame.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (float)x {
    return self.frame.origin.x;
}

- (void)setX:(float)newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (float)y {
    return self.frame.origin.y;
}

- (void)setY:(float)newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (float)width {
    return self.frame.size.width;
}

- (void)setWidth:(float)newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (float)height {
    return self.frame.size.height;
}

- (void)setHeight:(float)newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (float)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(float)newRight{
    CGRect frame = self.frame;
    frame.origin.x = newRight - frame.size.width;
    self.frame = frame;
}

- (float)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(float)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end
