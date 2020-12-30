//
//  DLAnimationInput.m
//  MixT
//
//  Created by 周冰烽 on 2020/10/26.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAnimationInput.h"

@implementation DLAnimationInput

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [transitionContext isAnimated] ? 0.55 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [containerView addSubview:toView];  //必须添加到动画容器View上。
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    CGFloat screenW = CGRectGetWidth(containerView.bounds);
    CGFloat screenH = CGRectGetHeight(containerView.bounds);
    CGFloat x = 35.f;
    CGFloat y = -1 * screenH;
    CGFloat w = screenW - x * 2;
    CGFloat h = screenH - screenH * 3 / 4.0;
    // 屏幕顶部
    CGRect beginFrame = CGRectMake(x, y, w, h);
    // 屏幕中间：
    CGRect showFrame = CGRectMake(x, screenH * 3 / 8.0, w, h);
    // 屏幕底部
    CGRect endFrame = CGRectMake(x, screenH, w, h);
    
    if (isPresenting) toView.frame = beginFrame;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // duration： 动画时长
    // delay： 决定了动画在延迟多久之后执行
    // damping：速度衰减比例。取值范围0 ~ 1，值越低震动越强
    // velocity：初始化速度，值越高则物品的速度越快
    // UIViewAnimationOptionCurveEaseInOut 加速，后减速
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
