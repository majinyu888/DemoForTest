//
//  POPAnimationVC.m
//  GithubDemoTest
//
//  Created by hb on 16/8/19.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "POPAnimationVC.h"

//lib
#import <pop/POP.h>

@interface POPAnimationVC ()

@property (nonatomic, strong) CALayer  *normalLayer;
@property (nonatomic, strong) CALayer  *popLayer;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView   *showView;

@end

@implementation POPAnimationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *itemPop = [[UIBarButtonItem alloc] initWithTitle:@"pop动画" style:UIBarButtonItemStylePlain target:self action:@selector(popAnimation)];
    UIBarButtonItem *itemNomal = [[UIBarButtonItem alloc] initWithTitle:@"普通动画" style:UIBarButtonItemStylePlain target:self action:@selector(nomalAnimation)];
    UIBarButtonItem *itemDecay = [[UIBarButtonItem alloc] initWithTitle:@"衰减动画" style:UIBarButtonItemStylePlain target:self action:@selector(decayAnimation)];
    UIBarButtonItem *itemSpring = [[UIBarButtonItem alloc] initWithTitle:@"弹簧动画" style:UIBarButtonItemStylePlain target:self action:@selector(springAnimation)];

    self.navigationItem.rightBarButtonItems = @[itemPop,itemNomal,itemDecay,itemSpring];
    
}

- (void)popAnimation
{
    // 处理normalLayer
    // CALayer动画移除后会突然出现在终点位置
    
    // 初始化POPLayer
    self.popLayer = [CALayer layer];
    self.popLayer.frame = CGRectMake(100, 100, 100, 100);
    self.popLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.popLayer];
    
    // 初始化POP动画
    POPBasicAnimation *popAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    popAnimation.toValue = [NSValue valueWithCGPoint:(CGPointMake(100 + 50, 400))];
    popAnimation.duration = 4.f;
    popAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 添加动画
    [self.popLayer pop_addAnimation:popAnimation forKey:nil];
    
    // 1.5s后移除
    [self performSelector:@selector(removePopAnimation) withObject:nil afterDelay:1.5];
}

- (void)nomalAnimation
{
    // 处理POPLayer
    // 我们发现即使POP动画移除了也会显示在当前位置
    // 初始化Layer
    self.normalLayer = [CALayer layer];
    self.normalLayer.frame = CGRectMake(100, 100, 100, 100);
    self.normalLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.normalLayer];
    
    // 初始化动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.fromValue = [NSValue valueWithCGPoint:self.normalLayer.position];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(100 + 50, 400)];
    basicAnimation.duration = 4.f;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 设定结束位置的值
    self.normalLayer.position = CGPointMake(100 + 50, 400);
    
    // 开始动画
    [self.normalLayer addAnimation:basicAnimation forKey:nil];
    
    // 1.5秒后移除动画
    [self performSelector:@selector(removeNormalAnimation) withObject:nil afterDelay:1.5];
}

- (void)decayAnimation
{
    // 初始化UIButton
    self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.button.frame = CGRectMake(0, 0, 100, 100);
    self.button.backgroundColor = [UIColor redColor];
    self.button.layer.cornerRadius = 50;
    self.button.layer.masksToBounds = YES;
    self.button.center = self.view.center;
    [self.view addSubview:self.button];
    
    [self.button addTarget:self action:@selector(buttonEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 初始化手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hanlePanGesture:)];
    // 添加手势
    [self.button addGestureRecognizer:panGesture];
}

- (void)springAnimation
{
    // 设置控制器的背景色
    self.view.backgroundColor = [UIColor blackColor];
    
    // 初始化View
    self.showView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 50, 50))];
    self.showView.backgroundColor = [UIColor cyanColor];
    self.showView.center = self.view.center;
    [self.view addSubview:self.showView];
    
    // 延迟1秒执行
    [self performSelector:@selector(startSpringAnimation) withObject:nil afterDelay:1.f];
}

#pragma mark --- 处理POPLayer

- (void)removePopAnimation
{
    [self.popLayer pop_removeAllAnimations];
}

#pragma mark --- 处理normalLayer

- (void)removeNormalAnimation
{
    CALayer *layer = self.normalLayer.presentationLayer;
    NSLog(@"%@", NSStringFromCGRect(layer.frame));
    NSLog(@"%@", NSStringFromCGRect(self.normalLayer.frame));
    [self.normalLayer removeAllAnimations];
}

#pragma mark --- 衰减动画

- (void)hanlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    // 获取定位点
    CGPoint translation = [recognizer translationInView:self.view];
    // recognizer.view.center指的就是button的center,手势已经添加到UIButton上
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    
    // 恢复坐标系
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    // 动画停止瞬间获取加速度
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // 获取加速度值
        CGPoint velocity = [recognizer velocityInView:self.view];
        // 初始化POP的decay(衰减动画)
        POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        decayAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [recognizer.view.layer pop_addAnimation:decayAnimation forKey:nil];
    }
}

- (void)buttonEvent:(UIButton *)button{
    
    [button.layer pop_removeAllAnimations];
}

#pragma mark --- 弹簧动画

- (void)startSpringAnimation
{
    // 初始化Spring动画
    POPSpringAnimation *sizeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    sizeAnimation.springSpeed = 0.f;
    
    sizeAnimation.toValue = [NSValue valueWithCGRect:(CGRectMake(0, 0, 200, 200))];
    
    // 添加动画
    [self.showView pop_addAnimation:sizeAnimation forKey:nil];
}






@end
