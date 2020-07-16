//
//  DLAnimationLeft.m
//  整理
//
//  Created by 周冰烽 on 2020/7/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAnimationLeft.h"

@implementation DLAnimationLeft

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [transitionContext isAnimated] ? 0.35 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BOOL isPresenting = (fromController == self.presentingViewController);
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    CGFloat screenWidth = CGRectGetWidth(containerView.bounds);
    CGFloat screenHeight = CGRectGetHeight(containerView.bounds);
    CGFloat width = screenWidth / 2.0;
    CGRect hiddenFrame = CGRectMake(-width, 0, width, screenHeight);
    CGRect showFrame = CGRectMake(0, 0, width, screenHeight);
    if (isPresenting) toView.frame = hiddenFrame;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        if (isPresenting) {
            toView.frame = showFrame;
        } else {
            fromView.frame = hiddenFrame;
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
