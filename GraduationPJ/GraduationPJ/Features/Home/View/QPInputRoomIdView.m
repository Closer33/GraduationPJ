//
//  QPInputRoomIdView.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPInputRoomIdView.h"
#import "MQVerViewInputView/MQVerCodeInputView.h"

@interface QPInputRoomIdView()

@property (nonatomic, strong) UIView *coverView;

@end

@implementation QPInputRoomIdView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.size = [self expectSize];
        [self setupUI];
        [self addToWindow];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.layer.cornerRadius = 9;
    
    UILabel *label = [[UILabel alloc] init];
    label.size = CGSizeMake(200, 30);
    label.top = 8;
    label.centerX = self.width / 2;
    label.text = @"请输入房间号";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    MQVerCodeInputView *verView = [[MQVerCodeInputView alloc]initWithFrame:CGRectMake(0, 45, self.size.width - 30, 50)];
    verView.maxLenght = 4;//最大长度
    verView.keyBoardType = UIKeyboardTypeNumberPad;
    [verView mq_verCodeViewWithMaxLenght];
     __weak __typeof__(self) weakSelf = self;
    verView.block = ^(NSString *text){
        __strong __typeof(self) strongSelf = weakSelf;
        if (text.length == 4) {
            if (strongSelf.completeBlcok) {
                strongSelf.completeBlcok(text);
                [strongSelf clickCoverView];
            }
        }
    };
    verView.centerX = self.width / 2;
    [self addSubview:verView];
}

- (void)addToWindow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.coverView = [[UIView alloc] initWithFrame:window.bounds];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0.5;
    [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCoverView)]];
    [window addSubview:self.coverView];
    
    self.centerX = self.coverView.centerX;
    self.centerY = self.coverView.centerY - 20;
    [window addSubview:self];
}

- (void)clickCoverView {
    [self.coverView removeFromSuperview];
    self.coverView = nil;
    [self removeFromSuperview];
}

- (CGSize)expectSize {
    return CGSizeMake(270, 110);
}

@end
