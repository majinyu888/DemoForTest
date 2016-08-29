//
//  HomeVC.m
//  GithubDemoTest
//
//  Created by hb on 16/8/19.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "HomeVC.h"

#import "POPAnimationVC.h" //facebook: animation framework
#import "PhotoListVC.h"    //photo
#import "CellHeightVC.h"   //cell height
#import "PopListVC.h"      //弹出列表

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
    self.title = @"测试Demo";
    
    maList = @[
               @"POP动画",
               @"图片浏览器",
               @"Cell高度自适应",
               @"弹出列表"
               ].mutableCopy;
    
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
    cell.backgroundColor = [Utils randomColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:cell.frame];
    lblTitle.text = maList[indexPath.item];
    lblTitle.font = [UIFont systemFontOfSize:15];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.center = cell.contentView.center;
    lblTitle.adjustsFontSizeToFitWidth = YES;
    lblTitle.minimumScaleFactor = 0.2;
    //    [lblTitle sizeToFit];//在不给定Frame的时候这个属性好使
    [cell.contentView addSubview:lblTitle];
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
        case 1: {
            PhotoListVC *photo = [[PhotoListVC alloc] init];
            [self.navigationController pushViewController:photo animated:YES];
            break;
        }
        case 2: {
            CellHeightVC *photo = [[CellHeightVC alloc] init];
            [self.navigationController pushViewController:photo animated:YES];
            break;
        }
            
        case 3: {
            PopListVC *popList = [[PopListVC alloc] init];
            [self.navigationController pushViewController:popList animated:YES];
            break;
        }
            
        default:
            break;
    }
}


@end
