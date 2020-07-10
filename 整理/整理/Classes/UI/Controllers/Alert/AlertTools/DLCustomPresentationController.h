//
//  DLCustomPresentationController.h
//  整理
//
//  Created by 周冰烽 on 2020/7/9.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLBaseAnimation.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLCustomPresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>
// 指定转场动画
@property(nonatomic, strong) DLBaseAnimation * animation;

@end

NS_ASSUME_NONNULL_END
