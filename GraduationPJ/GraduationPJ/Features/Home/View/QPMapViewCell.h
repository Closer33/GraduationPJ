//
//  QPMapViewCell.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QPMapViewCellModel;
@interface QPMapViewCell : UICollectionViewCell

- (void)setModel:(QPMapViewCellModel *)model;

@end

NS_ASSUME_NONNULL_END
