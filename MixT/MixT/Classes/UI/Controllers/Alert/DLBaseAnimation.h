//
//  DLBaseAnimation.h
//  整理
//
//  Created by 周冰烽 on 2020/7/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLBaseAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property(nonatomic, strong) UIViewController * presentingViewController;

@end

NS_ASSUME_NONNULL_END
