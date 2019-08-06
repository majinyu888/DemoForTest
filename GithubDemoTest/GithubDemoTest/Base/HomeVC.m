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
#import "PhotoListVC2.h"   //photo2
#import "CellHeightVC2.h"  //cell height
#import "PopListVC.h"      //弹出列表
#import "MyVC1.h"          //自定义转场动画
#import "CollectionViewPageVC.h"//分页
#import "WebViewVC.h"        //WebView 真实高度
#import "TableHeaderViewVC.h"//header 拉伸效果
#import "DispatchTimerVC.h" // 重复执行的gcd timer
#import "KVOController.h" // KVO 测试
#import "JYRoundMenuVC.h"  // 半圆菜单测试

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
    [self addNotification];
}

- (void)initData
{
    self.title = @"测试Demo";
    
    maList = @[
               @"POP动画",
               @"图片浏览器",
               @"弹出列表",
               @"自定义转场动画",
               @"Cell高度2",
               @"CollectionView分页",
               @"WebView真实高度",
               @"图片浏览器2",
               @"header拉伸效果",
               @"GCD timer",
               @"KVO 测试",
               @"半圆菜单"
               ].mutableCopy;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(screenSize.width, 80);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _clv.dataSource = self;
    _clv.delegate = self;
    _clv.backgroundColor = [UIColor whiteColor];
    [_clv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
}

- (void)initUI
{
    WS(ws);
    [ws.view addSubview:_clv];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [_clv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(padding);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - notificatiom

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)deviceOrientationChanged: (NSNotification *)noti {
    [self.clv reloadData];
}

#pragma mark - clv datasource & delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return maList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        [obj removeFromSuperview];
    }];
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
            PopListVC *popList = [[PopListVC alloc] init];
            [self.navigationController pushViewController:popList animated:YES];
            break;
        }
            
        case 3: {
            MyVC1 *vc = [[MyVC1 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 4: {
            CellHeightVC2 *vc = [[CellHeightVC2 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 5: {
            CollectionViewPageVC *vc = [[CollectionViewPageVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 6: {
            WebViewVC *vc = [[WebViewVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 7: {
            PhotoListVC2 *photo2 = [[PhotoListVC2 alloc] init];
            [self.navigationController pushViewController:photo2 animated:YES];
            break;
        }
            
        case 8: {
            TableHeaderViewVC *vc = [[TableHeaderViewVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 9: {
            DispatchTimerVC *vc = [[DispatchTimerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 10: {
            KVOController *vc = [[KVOController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 11: {
            JYRoundMenuVC *vc = [[JYRoundMenuVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}



@end
