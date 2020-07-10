//
//  Const.h
//  常用宏定义
//  整理
//
//  Created by 周冰烽 on 2020/6/1.
//  Copyright © 2020 周冰烽. All rights reserved.
//

// 屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
// 判断是否为刘海屏
#define kIPHONE_X \
({BOOL isPhoneX = NO;\
if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {\
    isPhoneX = NO;\
}\
CGSize size = [UIScreen mainScreen].bounds.size;\
NSInteger notchValue = size.width / size.height * 100;\
if (216 == notchValue || 46 == notchValue) {\
    isPhoneX = YES;\
}\
(isPhoneX);})
// 非安全区域头部高度
#define kTopUnSafeAreaHeight ({(kIPHONE_X) ? 40.0f : 20.0f;})
// 非安全区域底部高度
#define kBottomUnSafeAreaHeight ({(kIPHONE_X) ? 34.0f : 0.0f;})
// 导航栏交互区高度
#define kNavigationBarHeight 44.0f

#define kTabbarHeight 49.0f
