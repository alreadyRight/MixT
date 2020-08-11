//
//  DLBaseAnimation.m
//  整理
//
//  Created by 周冰烽 on 2020/7/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBaseAnimation.h"

@implementation DLBaseAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [transitionContext isAnimated] ? 0.35 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
}

@end
