//
//  CollectionViewPageVC.m
//  GithubDemoTest
//
//  Created by hb on 16/9/16.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "CollectionViewPageVC.h"
#import "PagedView.h"
#import "PageCollectionViewCell.h"

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
    [self.view addSubview:self.pagedView];
    
    [self.pagedView registerNib:NSStringFromClass([PageCollectionViewCell class])];
    self.pagedView.maCates = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14"].mutableCopy;
    
    self.pagedView.configCellWithIndexPath = ^(NSIndexPath *indexPath) {
        if (self.pagedView.maCates.count > indexPath.item) {
            PageCollectionViewCell *cell = (PageCollectionViewCell *)[weakSelf.pagedView reusedCell:indexPath];
            cell.lbl.text = weakSelf.pagedView.maCates[indexPath.item];
            cell.userInteractionEnabled = YES;
            return cell;
        } else {
            PageCollectionViewCell *cell = (PageCollectionViewCell *)[weakSelf.pagedView reusedCell:indexPath];;
            cell.lbl.text = nil;
            cell.userInteractionEnabled = NO;
            return cell;
        }
    };
    self.pagedView.onItemClickBlock = ^(NSIndexPath *indexPath) {
        
    };
    
    self.pagedView.rowCount = 4;
    self.pagedView.itemCountPerRow = 3;
    
}


@end
