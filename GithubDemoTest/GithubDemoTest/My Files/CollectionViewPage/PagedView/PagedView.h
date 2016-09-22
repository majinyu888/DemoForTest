//
//  PageCollectionView.h
//  GithubDemoTest
//
//  Created by hb on 16/9/20.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageCollectionViewFlowLayout;

@interface PagedView : UIView

/**
 根据indexPath配置Cell信息并返回Cell
 */
@property (nonatomic, copy) UICollectionViewCell *(^configCellWithIndexPath)(UICollectionView *collectionView, NSIndexPath *indexPath);

/**
 分类item点击的回调
 */
@property (nonatomic, copy) void (^onItemClickBlock)(NSIndexPath *indexPath);

/**
 自定义CollectionViewFlowLayout布局类
 */
@property (nonatomic, strong) PageCollectionViewFlowLayout *layout;

/**
 分类数组 :  默认[NSMuableArray array]
 */
@property (nonatomic, strong) NSMutableArray *maCates;

/**
 每行几个item : 默认 4个
 */
@property (nonatomic, assign) NSUInteger itemCountPerRow;

/**
 几行 默认 : 2行
 */
@property (nonatomic, assign) NSUInteger rowCount;

/**
 item高度 : 默认 屏幕宽度的 四分之一
 */

@property (nonatomic, assign) CGFloat itemHeight;

/**
 是否显示 pageControl  默认为YES
 */
@property (nonatomic, assign) BOOL isShowPageControl;


/**
 根据nibName注册Cell

 @param nibName 名字
 */
- (void)registerNib:(NSString *)nibName;

/**
 根据Class注册cell

 @param class class
 */
- (void)registerClass:(Class)class;


@end
