//
//  CollectionViewPageVC.m
//  GithubDemoTest
//
//  Created by hb on 16/9/16.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "CollectionViewPageVC.h"
#import "PagedView.h"

@interface CollectionViewPageVC ()

@property (nonatomic, strong) PagedView *pagedView;

@end

@implementation CollectionViewPageVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)dealloc
{
    
}

#pragma mark - Data & UI
//数据
- (void)initData
{
    self.pagedView = [[[NSBundle mainBundle] loadNibNamed:@"PagedView" owner:nil options:nil] lastObject];
//    self.pagedView.rowCount = 2;
//    self.pagedView.itemCountPerRow = 3;
//    self.pagedView.itemHeight = 30;
//    self.pagedView.maCates = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14"].mutableCopy;
//    self.pagedView.isShowPageControl = NO;
    [self.view addSubview:self.pagedView];

    WS(ws);
    [self.pagedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).with.offset(0);
        make.top.mas_equalTo(ws.view).with.offset(0);
        make.right.mas_equalTo(ws.view).with.offset(0);
        make.height.mas_equalTo(ScreenWidth);
    }];
    
    
}



#pragma mark - Notification Method



@end
