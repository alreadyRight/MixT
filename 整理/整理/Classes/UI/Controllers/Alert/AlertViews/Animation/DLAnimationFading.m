//
//  DLAnimationFade.m
//  整理
//
//  Created by 周冰烽 on 2020/7/9.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAnimationFading.h"

@implementation DLAnimationFading

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [transitionContext isAnimated] ? 0.35 : 0;
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
    // 判断是present 还是 dismiss
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    CGFloat screenW = CGRectGetWidth(containerView.bounds);
    CGFloat screenH = CGRectGetHeight(containerView.bounds);
    
    // 如果是淡入淡出的效果则单独设置,并不执行下面的语句
    CGFloat x = 40.0f;
    CGFloat y = screenH / 8.0 * 3.0;
    CGFloat width = screenW - 2 * x;
    CGFloat height = screenH / 4.0;
    CGRect frame = CGRectMake(x, y, width, height);
    if (isPresenting) toView.frame = frame;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        if (isPresenting) {
            toView.alpha = 1.0f;
        } else {
            fromView.alpha = 0.0f;
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
