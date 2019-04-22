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

#import "QPAccount.h"
#import "QPNetworkManager.h"

@interface QPHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIButton *runButton;
@property (nonatomic, strong) UIButton *joinButton;

@end

static NSString * const kCollectionViewReuseId = @"QPMapViewCell";

@implementation QPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    // 将用户信息发送到服务器
    [[QPNetworkManager shareInstance] GET:@"http://localhost:8181/api/v1/oauth" parameters:[QPAccount getUserInfo] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:nil];
}

- (void)setupUI {
    [self.view addSubview:self.collectionView];
    self.collectionView.size = CGSizeMake(self.view.width, self.view.width * 1.1);
    self.collectionView.x = 0;
    self.collectionView.centerY = self.view.centerY - 25;
    
    [self.view addSubview:self.runButton];
    self.runButton.size = CGSizeMake(50, 30);
    self.runButton.centerX = self.view.centerX;
    self.runButton.top = self.collectionView.bottom + 10;
    
    [self.view addSubview:self.joinButton];
    self.joinButton.size = CGSizeMake(50, 30);
    self.joinButton.centerY = self.runButton.centerY;
    self.joinButton.left = self.runButton.right + 10;
}

- (void)loadData {
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"track.plist" ofType:nil]];
    QPMapViewCellModel *model = [QPMapViewCellModel mj_objectWithKeyValues:dic];
    [self.dataArr addObject:model];
    [self.collectionView reloadData];
}

- (void)runButtonClick {
    
}

- (void)joinButtonClick {
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
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
        layout.itemSize = CGSizeMake(self.view.width - 40, self.view.width * 1.1);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[QPMapViewCell class] forCellWithReuseIdentifier:kCollectionViewReuseId];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
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
        [_joinButton addTarget:self action:@selector(joinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinButton;
}

@end
