//
//  MyNavController.m
//  GithubDemoTest
//
//  Created by hb on 16/8/30.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "MyAnimator.h"
#import "AppDelegate.h"
#import "MyVC2.h"

@interface NavigationControllerDelegate()<
UINavigationControllerDelegate
>
@property (strong, nonatomic) UINavigationController *myNav;
@property (strong, nonatomic) MyAnimator *animator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;


@end

@implementation NavigationControllerDelegate



- (void)setDeletateForNavagationVC:(UINavigationController *)nav
{
    _myNav = nav;
    _myNav.delegate = self;
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [nav.view addGestureRecognizer:panRecognizer];
    self.animator = [MyAnimator new];
}


- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.myNav.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.x > CGRectGetMidX(view.bounds) && self.myNav.viewControllers.count == 1){
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self.myNav pushViewController:[MyVC2 new] animated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        // fabs() 求浮点数的绝对值
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x < 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return self.animator;
    } else {
        return nil;
    }
}


@end
