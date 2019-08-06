//
//  JYRoundMenuView.h
//  GithubDemoTest
//
//  Created by hb on 2019/8/6.
//  Copyright © 2019 com.bm.hb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYRoundMenuItemView;
@class JYRoundMenuView;

@protocol JYRoundMenuViewDelegate <NSObject>

- (void)JYRoundMenu:(JYRoundMenuView *)menu onBaseMenuTaped:(UIButton *)baseBtn widthOpened:(BOOL)isOppened;
- (void)JYRoundMenu:(JYRoundMenuView *)menu onMenuItemTaped:(NSInteger)index;

@end


@interface JYRoundMenuView : UIView

+ (instancetype)roundMenuView:(NSArray<JYRoundMenuItemView *> *)items andSize:(CGSize)size andPosition:(CGPoint)center;
- (void)close;

@property (weak, nonatomic) id<JYRoundMenuViewDelegate> delegate;
@property (assign, nonatomic) CGFloat timeInterval;//弹出按钮的动画间隔0.1
@property (assign, nonatomic) CGFloat durationPerButton;//单个按钮动画的长度0.25
@property (assign, nonatomic) CGFloat springVelocity;//弹出
@property (assign, nonatomic) CGFloat springWithDamping;

@end

NS_ASSUME_NONNULL_END
