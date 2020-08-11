//
//  DLAnimationCenterFromBottom.m
//  整理
//
//  Created by 周冰烽 on 2020/7/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAnimationCenterFromBottom.h"

@implementation DLAnimationCenterFromBottom

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [transitionContext isAnimated] ? 0.55 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 1.获取源控制器、目标控制器、动画容器View
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    // 2. 获取源控制器、目标控制器 的View，但是注意二者在开始动画，消失动画，身份是不一样的：
    // 也可以直接通过上面获取控制器获取，比如：toViewController.view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [containerView addSubview:toView];  //必须添加到动画容器View上。
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    CGFloat screenW = CGRectGetWidth(containerView.bounds);
    CGFloat screenH = CGRectGetHeight(containerView.bounds);
    CGFloat x = 35.f;
    CGFloat y = -1 * screenH;
    CGFloat w = screenW - x * 2;
    CGFloat h = screenH - 120.f * 2;
    // 屏幕顶部
    CGRect beginFrame = CGRectMake(x, screenH, w, h);
    // 屏幕中间：
    CGRect showFrame = CGRectMake(x, 120.0, w, h);
    // 屏幕底部
    CGRect endFrame = CGRectMake(x, y, w, h);
    
    if (isPresenting) toView.frame = beginFrame;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isPresenting)
            toView.frame = showFrame;
        else
            fromView.frame = endFrame;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}

@end
