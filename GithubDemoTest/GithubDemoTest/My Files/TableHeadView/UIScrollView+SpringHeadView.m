//
//  UIScrollView+SpringHeadView.m
//  GithubDemoTest
//
//  Created by hb on 2017/3/7.
//  Copyright © 2017年 com.bm.hb. All rights reserved.
//

#import "UIScrollView+SpringHeadView.h"
#import <objc/runtime.h>

static char UIScrollViewSpringHeadView;

@implementation UIScrollView (SpringHeadView)

- (void)setTopView:(UIView *)topView
{
    [self willChangeValueForKey:@"SpringHeadView"];
    objc_setAssociatedObject(self, &UIScrollViewSpringHeadView, topView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"SpringHeadView"];
}

- (UIView *)topView
{
    return objc_getAssociatedObject(self, &UIScrollViewSpringHeadView);
}

- (void)addSpringHeadView:(UIView *)view
{
    self.contentInset = UIEdgeInsetsMake(view.bounds.size.height, 0, 0, 0);
    [self addSubview:view];
    view.frame = CGRectMake(0, -view.bounds.size.height, view.bounds.size.width, view.bounds.size.height);
    self.topView = view;
    self.delegate = self;
//    /// 使用kvo 监听scrollView的滚动
//    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

/// scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offy = scrollView.contentOffset.y;
    
    if (offy < 0) {
        self.topView.frame = CGRectMake(0, offy, self.topView.bounds.size.width, -offy);
    }
}

///// KVO
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    [self scrollViewDidScroll:self];
//}

@end
