//
//  DLAnimationRight.m
//  整理
//
//  Created by 周冰烽 on 2020/7/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAnimationRight.h"

@implementation DLAnimationRight

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [transitionContext isAnimated] ? 0.35 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BOOL isPresenting = (fromVC == self.presentingViewController);
    
    UIView *fromV = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toV = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *contrainerV = [transitionContext containerView];
    [contrainerV addSubview:toV];
    
    CGFloat screenWidth = CGRectGetWidth(contrainerV.bounds);
    CGFloat screenHeight = CGRectGetHeight(contrainerV.bounds);
    CGFloat width = screenWidth / 2.0;
    CGRect hiddenFrame = CGRectMake(screenWidth, 0, width, screenHeight);
    CGRect showFrame = CGRectMake(width, 0, width, screenHeight);
    
    if (isPresenting) toV.frame = hiddenFrame;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
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
