//
//  JYRoundMenuView.m
//  GithubDemoTest
//
//  Created by hb on 2019/8/6.
//  Copyright © 2019 com.bm.hb. All rights reserved.
//

#import "JYRoundMenuView.h"
#import "JYRoundMenuItemView.h"

@interface JYRoundMenuView()

@property (strong, nonatomic) NSArray<JYRoundMenuItemView *> *items;
@property (weak, nonatomic) UIButton *baseMenu;
@property (assign, nonatomic) BOOL opened;
@property (assign, nonatomic) CGSize baseBtnSize;

@end

@implementation JYRoundMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configView];
    }
    return self;
}

+ (instancetype)roundMenuView:(NSArray<JYRoundMenuItemView *> *)items andSize:(CGSize)size andPosition:(CGPoint)center {
    JYRoundMenuView *rsb = [[self alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    rsb.backgroundColor = [UIColor orangeColor];
    rsb.baseBtnSize = size;
    rsb.center = center;
    rsb.items = items;
    rsb.timeInterval = 0.1;
    rsb.durationPerButton = 0.25;
    rsb.springWithDamping = 0.5;
    rsb.springVelocity = 1;
    return rsb;
}

- (void)configView {
    self.backgroundColor = [UIColor clearColor];
    UIButton *baseBtn = [UIButton new];
    baseBtn.center = self.center;
    [baseBtn setTitle:@"+" forState:UIControlStateNormal];
    baseBtn.backgroundColor = [UIColor blueColor];
    [baseBtn addTarget:self action:@selector(baseBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:baseBtn];
    self.baseMenu = baseBtn;
}

- (void)baseBtnTouched:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(JYRoundMenu:onBaseMenuTaped:widthOpened:)]) {
        [self.delegate JYRoundMenu:self onBaseMenuTaped:sender widthOpened:self.opened];
    }
    
    if (_opened) {
        [self.items enumerateObjectsUsingBlock:^(JYRoundMenuItemView *obj, NSUInteger idx, BOOL *stop) {
            [UIView animateWithDuration:self.durationPerButton delay:idx * self.timeInterval usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                obj.transform = CGAffineTransformIdentity;
                obj.alpha = 0;
            } completion:^(BOOL finished) {
                self.opened = NO;
            }];
        }];
    } else {
        [self.items enumerateObjectsUsingBlock:^(JYRoundMenuItemView *obj, NSUInteger idx, BOOL *stop) {
            [UIView animateWithDuration:self.durationPerButton delay:idx * self.timeInterval usingSpringWithDamping:self.springWithDamping initialSpringVelocity:self.springVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGPoint p = [self pointForIndex:idx];
                obj.frame = CGRectMake(p.x, p.y, obj.frame.size.width, obj.frame.size.height);
                obj.alpha = 1;
            } completion:^(BOOL finished) {
                if (idx == self.items.count - 1) {
                    self.opened = YES;
                }
            }];
        }];
    }
}

- (CGPoint)pointForIndex:(NSUInteger)index {
    CGPoint center = self.baseMenu.center;
    CGFloat r = 240;
    CGFloat insertX = 60;
    CGFloat insertY = 30;
    
    CGPoint point2 = CGPointMake(center.x - r*cos(M_PI / 8 - M_PI*3 / 48) + insertX, center.y - r*sin(M_PI / 8 - M_PI * 3 / 48) + insertY);
    CGPoint point3 = CGPointMake(center.x - r*cos(M_PI / 4 - M_PI / 24) + insertX, center.y - r*sin(M_PI / 4 - M_PI / 24)+ insertY);
    CGPoint point4 = CGPointMake(center.x - r*cos(M_PI * 3 / 8 - M_PI / 48) + insertX, center.y - r*sin(M_PI * 3 / 8 - M_PI / 48)+ insertY);
    if (index == 0) {
        return point2;
    } else if (index == 1) {
        return point3;
    } else {
        return point4;
    }
}

- (void)onItemTaped:(UITapGestureRecognizer *)gesture {
    NSInteger index = gesture.view.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(JYRoundMenu:onMenuItemTaped:)]) {
        [self.delegate JYRoundMenu:self onMenuItemTaped:index];
    }
}

- (void)setItems:(NSArray<JYRoundMenuItemView *> *)items {
    _items = items;
    int i = 0;
    for (JYRoundMenuItemView *item in _items) {
        item.center = self.baseMenu.center;
        item.tag = i;
        item.alpha = 0;
        [self insertSubview:item belowSubview:_baseMenu];
        item.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onItemTaped:)];
        [item addGestureRecognizer:tap];
        i ++;
    }
}

- (void)setRoundButton:(BOOL)roundButton {
    if (roundButton) {
        for (JYRoundMenuItemView *item in _items) {
            item.layer.cornerRadius = item.bounds.size.width / 2;
            item.layer.masksToBounds = YES;
        }
        self.baseMenu.layer.cornerRadius = _baseBtnSize.width / 2;
        self.baseMenu.layer.masksToBounds = YES;
    }
}

- (void)setBaseBtnSize:(CGSize)baseBtnSize{
    _baseBtnSize = baseBtnSize;
    _baseMenu.bounds = CGRectMake(0, 0, baseBtnSize.width, baseBtnSize.height);
}

#pragma mark - 外界方法

- (void)close {
    [self.items enumerateObjectsUsingBlock:^(JYRoundMenuItemView *obj, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:self.durationPerButton delay:idx * self.timeInterval usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            obj.transform = CGAffineTransformIdentity;
            obj.alpha = 0;
        } completion:^(BOOL finished) {
            self.opened = NO;
        }];
    }];
}

#pragma mark - 点击事件  超出也可以响应

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //if内的条件应该为，当触摸点point超出蓝色部分，但在黄色部分时
    for (UIView * sub in self.subviews) {
        CGPoint po = [self convertPoint:point toView:sub];
        if (CGRectContainsPoint(sub.bounds, po)) {
            return YES;
        }
    }
    return [super pointInside:point withEvent:event];
}


@end
