//
//  QPRoomView.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPRoomView.h"
#import <UIImageView+WebCache.h>
#import "QPAccount.h"
#import "QPRoomModel.h"

@interface QPRoomView()

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) NSString *roomId;
@property (weak, nonatomic) IBOutlet UILabel *roomIdLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBuuton;
@property (weak, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *joinnerImagView;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinnerLabel;


@end

@implementation QPRoomView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addToWindow];
}

- (void)addToWindow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.coverView = [[UIView alloc] initWithFrame:window.bounds];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0.5;
    [window addSubview:self.coverView];
    
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.layer.cornerRadius = 9;
    self.centerX = self.coverView.centerX;
    self.centerY = self.coverView.centerY - 20;
    [window addSubview:self];
}

- (void)removeFromWindow {
    [self.coverView removeFromSuperview];
    self.coverView = nil;
    [self removeFromSuperview];
}

- (IBAction)closeButtonClick:(id)sender {
    if (self.clseRoomBlock) {
        self.clseRoomBlock(self.roomId);
    }
    [self removeFromWindow];
}

- (void)loadInitDataWithRoomId:(NSString *)roomId {
    self.roomIdLabel.text = [NSString stringWithFormat:@"房间号:%@", roomId];
    NSDictionary *userDic = [QPAccount getUserInfo];
    [self.ownerImageView sd_setImageWithURL:userDic[@"figureurl"]];
    self.ownerLabel.text = userDic[@"nickname"];
}

- (void)loadDataWithDic:(NSDictionary *)dic isOwner:(BOOL)isOwner {
    QPRoomModel *model = [QPRoomModel mj_objectWithKeyValues:dic];
    self.roomIdLabel.text = [NSString stringWithFormat:@"房间号:%@", model.roomId];
    [self.joinnerImagView sd_setImageWithURL:[NSURL URLWithString:[model.userInfos[1] figureurl]]];
    self.joinnerLabel.text = [model.userInfos[1] nickname];
    if (isOwner) {
        [self.startBuuton setTitle:@"开始游戏" forState:UIControlStateNormal];
        self.startBuuton.enabled = YES;
    } else {
        [self.ownerImageView sd_setImageWithURL:[NSURL URLWithString:[model.userInfos[0] figureurl]]];
        self.ownerLabel.text = [model.userInfos[0] nickname];
        [self.startBuuton setTitle:@"等待房主开始开始游戏" forState:UIControlStateNormal];
    }
    NSLog(@"123");
}

@end
