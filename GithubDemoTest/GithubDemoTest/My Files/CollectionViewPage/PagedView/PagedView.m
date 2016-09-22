//
//  PageCollectionView.m
//  GithubDemoTest
//
//  Created by hb on 16/9/20.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "PagedView.h"
#import "PageCollectionViewFlowLayout.h"

@interface PagedView()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate
>{
    NSInteger itemCountOnePage;/// 每页能显示多少个item
    NSInteger currentPage;/// 默认是0
    CGFloat  _itemWidth;/// 单个item的宽度 和每行的个数相关
}

/// 网格视图
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/// 分页视图
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/// CollectionView的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consCollectionViewHeight;

@end

@implementation PagedView

#pragma mark - Life Cycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self defaultSetting];
}

- (void)defaultSetting
{
    _maCates = [NSMutableArray array];
    _itemCountPerRow = 4;
    _rowCount = 2;
    itemCountOnePage = _itemCountPerRow * _rowCount;
    _itemWidth = [UIScreen mainScreen].bounds.size.width/_itemCountPerRow;
    _itemHeight = [UIScreen mainScreen].bounds.size.width/4;
    currentPage = 0;
    _isShowPageControl = YES;
    
    _layout = [[PageCollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout.itemCountPerRow = _itemCountPerRow;
    _layout.rowCount = _rowCount;
    _collectionView.collectionViewLayout = _layout;
    
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    _consCollectionViewHeight.constant = _itemHeight * _rowCount;
    
    _pageControl.currentPage = currentPage;
    _pageControl.numberOfPages = _maCates.count % itemCountOnePage == 0 ? _maCates.count / itemCountOnePage : (_maCates.count / itemCountOnePage)+ 1;
    _pageControl.hidesForSinglePage = YES;
    _pageControl.defersCurrentPageDisplay = YES;
}

- (void)updateSetting
{
    itemCountOnePage = _itemCountPerRow * _rowCount;
    _itemWidth = [UIScreen mainScreen].bounds.size.width/_itemCountPerRow;
    _layout.itemCountPerRow = _itemCountPerRow;
    _layout.rowCount = _rowCount;
    _consCollectionViewHeight.constant = _itemHeight * _rowCount;
    [_collectionView reloadData];
    
    currentPage = 0;
    _pageControl.currentPage = currentPage;
    _pageControl.numberOfPages = _maCates.count % itemCountOnePage == 0 ? _maCates.count / itemCountOnePage : (_maCates.count / itemCountOnePage)+ 1;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_isShowPageControl) {
        if (_maCates.count <= itemCountOnePage) {
            _pageControl.hidden = YES;
            self.frame = CGRectMake(self.frame.origin.x,
                                    self.frame.origin.y,
                                    [UIScreen mainScreen].bounds.size.width,
                                    self.collectionView.frame.origin.y + self.collectionView.frame.size.height);
        } else {
            _pageControl.hidden = NO;
            self.frame = CGRectMake(self.frame.origin.x,
                                    self.frame.origin.y,
                                    [UIScreen mainScreen].bounds.size.width,
                                    self.pageControl.frame.origin.y + self.pageControl.frame.size.height);
        }
        
    } else {
        _pageControl.hidden = YES;
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                [UIScreen mainScreen].bounds.size.width,
                                self.collectionView.frame.origin.y + self.collectionView.frame.size.height);
    }
    
}

#pragma mark - Public Method

- (void)registerNib:(NSString *)nibName
{
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    if (!nib) {
        NSLog(@"nib 名称 不正确 请检查名字");
    } else {
        [_collectionView registerNib:nib forCellWithReuseIdentifier:nibName];
    }
}

- (void)registerClass:(Class)class
{
    if (!class) {
        NSLog(@"class 不能为nil");
    } else {
        [_collectionView registerClass:class forCellWithReuseIdentifier:NSStringFromClass(class)];
    }
}

#pragma mark - Setters

- (void)setMaCates:(NSMutableArray *)maCates
{
    if (maCates.count == 0 || !maCates) {
        return;
    } else {
        _maCates = maCates;
        [self updateSetting];
    }
}

- (void)setRowCount:(NSUInteger)rowCount
{
    if (_rowCount == rowCount) {
        return;
    } else {
        _rowCount = rowCount;
        [self updateSetting];
    }
}

- (void)setItemCountPerRow:(NSUInteger)itemCountPerRow
{
    if (_itemCountPerRow == itemCountPerRow) {
        return;
    } else {
        _itemCountPerRow = itemCountPerRow;
        [self updateSetting];
    }
}

- (void)setItemHeight:(CGFloat)itemHeight
{
    if (_itemHeight == itemHeight) {
        return;
    } else {
        _itemHeight = itemHeight;
        [self updateSetting];
    }
}

- (void)setIsShowPageControl:(BOOL)isShowPageControl
{
    if (_isShowPageControl == isShowPageControl) {
        return;
    } else {
        _isShowPageControl = isShowPageControl;
        [self updateSetting];
    }
}

#pragma mark - CollectionView Datasource

/// Cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.maCates.count % itemCountOnePage == 0 ? self.maCates.count : (1 + (self.maCates.count/itemCountOnePage)) * itemCountOnePage;
}

/// Cell 尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_itemWidth, _itemHeight);
}

/// Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.maCates.count == 0) {
        return nil;
    }
    
    if (self.configCellWithIndexPath) {
        return self.configCellWithIndexPath(collectionView, indexPath);
    } else {
        return nil;
    }
}

/// 每组之间的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

/// Cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

/// Header Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
/// Footer Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
/// 重用的 Header 或者 Footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - CollectionView Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.maCates.count > indexPath.item) {
        return YES;
    } else {
        return NO;
    }
}

/// Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /// block 回调
    if (self.onItemClickBlock) {
        self.onItemClickBlock(indexPath);
    }
}

#pragma mark - ScrollView Delegate
/// 滑动减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _collectionView) {
        // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
        currentPage = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
        //根据scrollView 的位置对page 的当前页赋值
        _pageControl.currentPage = currentPage;
    }
}

@end
