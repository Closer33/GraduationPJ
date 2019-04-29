//
//  QPHomeViewController.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPHomeViewController.h"
#import "QPMapViewCell.h"
#import "QPMapViewCellModel.h"
#import <MJExtension.h>
#import "QPSocketManager.h"
#import "QPAccount.h"
#import "QPNetworkManager.h"
#import "QPInputRoomIdView.h"
#import "QPRoomView.h"
#import "UIViewController+AlertView.h"
#import "QPRunViewController.h"

@interface QPHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIButton *runButton;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UIButton *rebotButton;
@property (nonatomic, strong) QPRoomView *roomView;

@end

static NSString * const kCollectionViewReuseId = @"QPMapViewCell";

@implementation QPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"趣跑";
    [self setupUI];
    [self loadData];
    [self handleSocket];
}

- (void)setupUI {
    [self setupNavgationBar];
    
    [self.view addSubview:self.collectionView];
    self.collectionView.size = CGSizeMake(self.view.width, self.view.width * 1.2);
    self.collectionView.x = 0;
    self.collectionView.centerY = self.view.centerY - 10;
    
    [self.view addSubview:self.runButton];
    self.runButton.size = CGSizeMake(70, 70);
    self.runButton.centerX = self.view.centerX;
    self.runButton.bottom = self.view.height - 15;
    self.runButton.layer.cornerRadius = 35;
    
    [self.view addSubview:self.joinButton];
    self.joinButton.size = CGSizeMake(50, 50);
    self.joinButton.centerY = self.runButton.centerY;
    self.joinButton.centerX = self.view.width / 4 * 3;
    self.joinButton.layer.cornerRadius = 25;
    
    [self.view addSubview:self.rebotButton];
    self.rebotButton.size = CGSizeMake(50, 50);
    self.rebotButton.centerY = self.runButton.centerY;
    self.rebotButton.centerX = self.view.width / 4;
    self.rebotButton.layer.cornerRadius = 25;
}

- (void)setupNavgationBar {
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(settingItemClick)];
    UIBarButtonItem *historyItem = [[UIBarButtonItem alloc] initWithTitle:@"历史" style:UIBarButtonItemStyleDone target:self action:@selector(historyItemClick)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:settingItem, historyItem, nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"社区" style:UIBarButtonItemStyleDone target:self action:@selector(xommunityItemClick)];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.runButton.bottom = self.view.height - 15 - self.view.safeAreaInsets.bottom;
    self.joinButton.centerY = self.runButton.centerY;
    self.rebotButton.centerY = self.runButton.centerY;
}

- (void)loadData {
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"track.plist" ofType:nil]];
    QPMapViewCellModel *model = [QPMapViewCellModel mj_objectWithKeyValues:dic];
    [self.dataArr addObject:model];
    [self.collectionView reloadData];
}

- (void)handleSocket {
    [QPSocketManager shareInstance].successBlock = ^(BOOL isScuuess) {
        if (!isScuuess) {
            [self showAlertViewWithType:QPAlertViewTypeConnectFiled];
        }
    };
    weakify(self);
    [QPSocketManager shareInstance].messageBlock = ^(NSDictionary *dict) {
        // 创建房间成功 返回 roomId
        strongify(self)
        if ([dict[@"code"] intValue] == 1) {
            self.roomView = [[NSBundle mainBundle]loadNibNamed:@"QPRoomView" owner:nil options:nil].firstObject;
            [self.roomView loadInitDataWithRoomId:dict[@"result"][@"roomId"]];
        }
        // 加入房间成功
        if ([dict[@"code"] intValue] == 2) {
            if (self.roomView) {
                [self.roomView loadDataWithDic:dict[@"result"] isOwner:YES];
            } else {
                self.roomView = [[NSBundle mainBundle]loadNibNamed:@"QPRoomView" owner:nil options:nil].firstObject;
                [self.roomView loadDataWithDic:dict[@"result"] isOwner:NO];
            }
        }
        weakify(self)
        self.roomView.clseRoomBlock = ^(NSString *roomId) {
            strongify(self)
            self.roomView = nil;
            [[QPSocketManager shareInstance] close];
        };
        // 加入房间失败 房间号错误
        if ([dict[@"code"] intValue] == 3) {
            [self showAlertViewWithType:QPAlertViewTypeRoomIdError];
        }
        // 对手退出房间
        if ([dict[@"code"] intValue] == 4) {
            [self.roomView loadInitDataWithRoomId:dict[@"result"][@"roomId"]];
        }
    };
    [QPSocketManager shareInstance].closeBlock = ^{
        if (self.roomView) {
            [self.roomView removeFromWindow];
            self.roomView = nil;
            [self showAlertViewWithType:QPAlertViewTypeRoomDisappear];
        }
    };
}

- (void)runButtonClick {
    [[QPSocketManager shareInstance] connectWithProtocol:[NSArray arrayWithObjects:@"create", [QPAccount getOpenId], nil]];
}

- (void)joinButtonClick {
    QPInputRoomIdView *roomIdView = [QPInputRoomIdView new];
    roomIdView.completeBlcok = ^(NSString * text) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [QPSocketManager.shareInstance connectWithProtocol:[NSArray arrayWithObjects:text, [QPAccount getOpenId], nil]];
        });
    };
}

- (void)rebotButtonClick {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择人机难度" message:@"人机模式默认角色为小偷，且跑完全程才算有效成绩" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"初级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:[QPRunViewController new] animated:YES completion:nil];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"中级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:[QPRunViewController new] animated:YES completion:nil];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"高级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:[QPRunViewController new] animated:YES completion:nil];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QPMapViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewReuseId forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell setModel:self.dataArr[0]];
    }
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.view.width - 40, self.view.width * 1.2);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[QPMapViewCell class] forCellWithReuseIdentifier:kCollectionViewReuseId];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return _collectionView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGFloat contentOffsetX = scrollView.contentOffset.x + 20;
//    CGFloat halfItemWidth = (self.view.width - 40) / 2 + 5;
//    NSInteger index = (contentOffsetX + halfItemWidth) / halfItemWidth / 2;
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//}
//

// 减速动画开始前被调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    CGFloat contentOffsetX = scrollView.contentOffset.x + 20;
//    CGFloat halfItemWidth = (self.view.width - 40) / 2 + 5;
//    NSInteger index = (contentOffsetX + halfItemWidth) / halfItemWidth / 2;
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat contentOffsetX = scrollView.contentOffset.x + 20;
    CGFloat halfItemWidth = (self.view.width - 40) / 2 + 5;
    NSInteger index = (contentOffsetX + halfItemWidth) / halfItemWidth / 2;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UIButton *)runButton {
    if (!_runButton) {
        _runButton = [[UIButton alloc] init];
        _runButton.backgroundColor = [UIColor greenColor];
        [_runButton setTitle:@"开始" forState:UIControlStateNormal];
        [_runButton addTarget:self action:@selector(runButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _runButton;
}

- (UIButton *)joinButton {
    if (!_joinButton) {
        _joinButton = [[UIButton alloc] init];
        _joinButton.backgroundColor = [UIColor orangeColor];
        [_joinButton setTitle:@"加入" forState:UIControlStateNormal];
        [_joinButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_joinButton addTarget:self action:@selector(joinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinButton;
}

- (UIButton *)rebotButton {
    if (!_rebotButton) {
        _rebotButton = [[UIButton alloc] init];
        _rebotButton.backgroundColor = [UIColor orangeColor];
        [_rebotButton setTitle:@"人机" forState:UIControlStateNormal];
        [_rebotButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_rebotButton addTarget:self action:@selector(rebotButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rebotButton;
}

@end
