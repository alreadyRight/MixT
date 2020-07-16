//
//  DLTimeAnimation.m
//  整理
//
//  Created by 周冰烽 on 2020/7/15.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLTimeAnimation.h"

@implementation DLTimeAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [transitionContext isAnimated] ? 0.55 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BOOL isPresenting = (fromVC == self.presentingViewController);
    
    UIView *fromV = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toV = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerV = [transitionContext containerView];
    [containerV addSubview:toV];
    
    CGFloat screenH = CGRectGetHeight(containerV.bounds);
    CGFloat screenW = CGRectGetWidth(containerV.bounds);
    CGFloat x = 30;
    CGFloat height = 300;
    CGFloat y = screenH - height;
    CGFloat width = screenW - 2 * x;
    CGRect showFrame = CGRectMake(x, y, width, height - kBottomUnSafeAreaHeight);
    CGRect hiddenFrame = CGRectMake(x, screenH, width, height - kBottomUnSafeAreaHeight);
    
    if (isPresenting) toV.frame = hiddenFrame;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isPresenting) {
            toV.frame = showFrame;
        } else {
            fromV.frame = hiddenFrame;
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
