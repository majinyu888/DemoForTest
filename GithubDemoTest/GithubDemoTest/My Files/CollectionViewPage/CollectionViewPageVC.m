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
    __weak typeof(self) weakSelf = self;
    
    self.pagedView = [[[NSBundle mainBundle] loadNibNamed:@"PagedView" owner:nil options:nil] lastObject];
    self.pagedView.maCates = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14"].mutableCopy;
    self.pagedView.onItemClickBlock = ^(NSIndexPath *indexPath) {
        [weakSelf showMessage:[NSString stringWithFormat:@"第%ld个item点击了",indexPath.item + 1]];
    };
//    self.pagedView.rowCount = 2;
//    self.pagedView.itemCountPerRow = 3;
//    self.pagedView.itemHeight = 30;
//    self.pagedView.isShowPageControl = NO;
    
    [self.view addSubview:self.pagedView];
}



#pragma mark - Custom Methods

/**
 *  显示提示信息
 *
 *  @param msg 要显示的字符串
 */
- (void)showMessage:(NSString *)msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

@end
