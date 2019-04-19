//
//  QPMapViewCell.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPMapViewCell.h"
#import <MAMapKit/MAMapKit.h>

@interface QPMapViewCell ()

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation QPMapViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 9;
        self.contentView.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.mapView];
    }
    return self;
}

- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        _mapView.userInteractionEnabled = NO;
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
        for (id view in _mapView.subviews) {
            if ([view class] == [UIImageView class]) {
                [(UIImageView *)view removeFromSuperview];
            }
        }
    }
    return _mapView;
}

@end
