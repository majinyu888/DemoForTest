//
//  HomeVC.m
//  GithubDemoTest
//
//  Created by hb on 16/8/19.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "HomeVC.h"
#import "Header.h"

#import "POPAnimationVC.h" //facebook: animation framework

@interface HomeVC ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>{
    NSMutableArray *maList;
}

@property (nonatomic, strong) UICollectionView *clv;

@end

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)initData
{
    maList = @[@"POP动画",@"HHHH"].mutableCopy;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    _clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _clv.dataSource = self;
    _clv.delegate = self;
    _clv.backgroundColor = [UIColor whiteColor];
    [_clv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

- (void)initUI
{
    WS(ws);
    [ws.view addSubview:_clv];
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [_clv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(padding);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return maList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.font = [UIFont systemFontOfSize:15];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = maList[indexPath.item];
    [lblTitle sizeToFit];
    lblTitle.center = cell.contentView.center;
    [cell.contentView addSubview:lblTitle];
    cell.backgroundColor = [Utils randomColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item) {
        case 0: {
            POPAnimationVC *pop = [[POPAnimationVC alloc] init];
            [self.navigationController pushViewController:pop animated:YES];
            break;
        }
            
        default:
            break;
    }
}


@end
