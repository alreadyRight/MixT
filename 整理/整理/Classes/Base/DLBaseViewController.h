//
//  DLBaseViewController.h
//  整理
//
//  Created by 周冰烽 on 2020/6/1.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLBaseViewController : UIViewController

/// 默认初始化
- (void)setupUI;

/// 默认带标题的导航栏
- (void)setupTitleNaviBar;

/// 默认带返回按钮和标题的导航栏
- (void)setupTitleAndBackNaviBar;

/// 自定义导航栏
/// @param leftView 导航栏左方视图
/// @param centerView 导航栏中间视图
/// @param rightView 导航栏右边视图
- (void)customNaviBarWithLeftView:(UIView *)leftView centerView:(UIView *)centerView rightView:(UIView *)rightView;

@end

NS_ASSUME_NONNULL_END
