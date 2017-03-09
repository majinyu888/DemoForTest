//
//  UIScrollView+SpringHeadView.h
//  GithubDemoTest
//
//  Created by hb on 2017/3/7.
//  Copyright © 2017年 com.bm.hb. All rights reserved.
//

#import <UIKit/UIKit.h>

//headView 的高度
#define SpringHeadViewHeight 200

@interface UIScrollView (SpringHeadView)<
UIScrollViewDelegate
>

//在分类增加了属性，这个是利用runtime实现的
@property (nonatomic, weak) UIView *topView;

- (void)addSpringHeadView:(UIView *)view;

@end
