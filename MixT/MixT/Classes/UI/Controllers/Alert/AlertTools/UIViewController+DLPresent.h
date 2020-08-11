//
//  UIViewController+DLPresent.h
//  整理
//
//  Created by 周冰烽 on 2020/7/27.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLBaseAnimation.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DLPresent)

- (void)presentViewController:(UIViewController *)viewControllerToPresent animation:(DLBaseAnimation *)animation completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
