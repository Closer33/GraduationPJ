//
//  QPRunInfoView.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/28.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPRunInfoView.h"

@interface QPRunInfoView()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@end

@implementation QPRunInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor orangeColor];
    self.alpha = 0.5;
    self.layer.cornerRadius = 10;
}

@end
