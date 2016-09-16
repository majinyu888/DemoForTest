//
//  JYCollectionViewFlowLayout.h
//  GithubDemoTest
//
//  Created by hb on 16/9/16.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCollectionViewFlowLayout : UICollectionViewFlowLayout

// 一行中cell的个数
@property (nonatomic, assign) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic, assign) NSUInteger rowCount;


@end
