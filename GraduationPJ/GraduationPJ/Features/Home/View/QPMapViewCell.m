//
//  QPMapViewCell.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPMapViewCell.h"
#import <MAMapKit/MAMapKit.h>
#import "QPMapViewCellModel.h"

@interface QPMapViewCell ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) QPMapViewCellModel *model;

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
        
        [self.contentView addSubview:self.distanceLabel];
        self.distanceLabel.size = CGSizeMake(50, 30);
        self.distanceLabel.bottom = self.height - 10;
        self.distanceLabel.right = self.width - 10;
    }
    return self;
}

- (void)setModel:(QPMapViewCellModel *)model {
    _model = model;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [model.centerCoordinate[@"latitude"] doubleValue];
    coordinate.longitude = [model.centerCoordinate[@"longitude"] doubleValue];
    self.mapView.centerCoordinate = coordinate;
    self.mapView.zoomLevel = model.zoomLevel;
    self.distanceLabel.text = model.distance;
    
    int pointCount = (int)[model.points count];
    if (pointCount < 1) {
        return;
    }
    CLLocationCoordinate2D *allCoordinates = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));
    for (int i = 0; i < pointCount; i++) {
        allCoordinates[i].latitude = [model.points[i][@"latitude"] doubleValue];
        allCoordinates[i].longitude = [model.points[i][@"longitude"] doubleValue];
    }
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:allCoordinates count:pointCount];
    [self.mapView addOverlay:polyline];
    
    [self setAnnotation];
}

- (void)setAnnotation {
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate[2];
    coordinate[0].latitude = [_model.points[0][@"latitude"] doubleValue];
    coordinate[0].longitude = [_model.points[0][@"longitude"] doubleValue];
    startAnnotation.coordinate = coordinate[0];
    startAnnotation.title = @"起点";
    [self.mapView addAnnotation:startAnnotation];
    
    MAPointAnnotation *endAnnotation = [[MAPointAnnotation alloc] init];
    coordinate[1].latitude = [[_model.points lastObject][@"latitude"] doubleValue];
    coordinate[1].longitude = [[_model.points lastObject][@"longitude"] doubleValue];
    endAnnotation.coordinate = coordinate[1];
    endAnnotation.title = @"终点";
    [self.mapView addAnnotation:endAnnotation];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        if ([annotation.title isEqualToString:@"终点"]) {
            annotationView.pinColor = MAPinAnnotationColorGreen;
        }
        return annotationView;
    }
    return nil;
}

- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
//        _mapView.userInteractionEnabled = NO;
//        _mapView.showsCompass = NO;
//        _mapView.showsScale = NO;
        _mapView.delegate = self;
//        for (id view in _mapView.subviews) {
//            if ([view class] == [UIImageView class]) {
//                [(UIImageView *)view removeFromSuperview];
//            }
//        }
    }
    return _mapView;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _distanceLabel;
}

@end
