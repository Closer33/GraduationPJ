//
//  QPMapViewCellModel.h
//  GraduationPJ
//
//  Created by yinquan on 2019/4/20.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPMapViewCellModel : NSObject

@property (nonatomic, strong) NSArray *points;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, assign) NSInteger zoomLevel;
@property (nonatomic, strong) NSDictionary *centerCoordinate;

@end
