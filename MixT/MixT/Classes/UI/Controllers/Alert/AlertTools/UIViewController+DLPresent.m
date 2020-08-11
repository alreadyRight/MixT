//
//  UIViewController+DLPresent.m
//  整理
//
//  Created by 周冰烽 on 2020/7/27.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "UIViewController+DLPresent.h"
#import "DLCustomPresentationController.h"

@implementation UIViewController (DLPresent)

- (void)presentViewController:(UIViewController *)viewControllerToPresent animation:(DLBaseAnimation *)animation completion:(void (^)(void))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        DLCustomPresentationController *presentingVC = [[DLCustomPresentationController alloc] initWithPresentedViewController:viewControllerToPresent presentingViewController:self];
        viewControllerToPresent.transitioningDelegate = presentingVC;
        presentingVC.animation = animation;
        [self presentViewController:viewControllerToPresent animated:YES completion:nil];
    });
}


@end
