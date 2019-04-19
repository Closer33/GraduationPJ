//
//  QPHomeViewController.m
//  GraduationPJ
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 WTU. All rights reserved.
//

#import "QPHomeViewController.h"
#import "QPMapViewCell.h"

@interface QPHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString * const kCollectionViewReuseId = @"QPMapViewCell";

@implementation QPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.collectionView];
    self.collectionView.size = CGSizeMake(self.view.width, self.view.width * 1.1);
    self.collectionView.x = 0;
    self.collectionView.centerY = self.view.centerY - 25;
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QPMapViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewReuseId forIndexPath:indexPath];
    return cell;
}


@end
