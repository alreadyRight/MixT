//
//  DLBaseViewController.m
//  整理
//
//  Created by 周冰烽 on 2020/6/1.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBaseViewController.h"
#import "UIButton+DLAdaptiveButton.h"

@interface DLBaseViewController ()

@property(nonatomic, weak) DLNavigationBar * naviBar;

@end

@implementation DLBaseViewController

#pragma mark - LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}



#pragma mark - UI context

- (void)setupUI {
    self.view.backgroundColor = [UIColor screenColor];
    // 隐藏自带导航栏
    [self.navigationController setNavigationBarHidden:YES];
    // 默认设置一个带标题的导航栏
    [self setupTitleNaviBar];
}

// 设置自定义导航栏(只带标题)
- (void)setupTitleNaviBar {
    DLNavigationBar *naviBar = [[DLNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight + kTopUnSafeAreaHeight + 1)];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textColor = [UIColor normalTextColor];
    naviBar.navigationCenterBar = titleLabel;
    [self.naviBar removeFromSuperview];
    self.naviBar = naviBar;
    [self.view addSubview:self.naviBar];
}

// 设置自定义导航栏(带标题和返回按钮)
- (void)setupTitleAndBackNaviBar {
    DLNavigationBar *naviBar = [[DLNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight + kTopUnSafeAreaHeight + 1)];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textColor = [UIColor normalTextColor];
    naviBar.navigationCenterBar = titleLabel;
    UIButton *leftButton = [[UIButton alloc] initHorizontalWithTitle:@"返回" image:[UIImage backIcon]];
    [leftButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    naviBar.navigationLeftBar = leftButton;
    [self.naviBar removeFromSuperview];
    self.naviBar = naviBar;
    [self.view addSubview:self.naviBar];
}

- (void)customNaviBarWithLeftView:(UIView *)leftView centerView:(UIView *)centerView rightView:(UIView *)rightView {
    DLNavigationBar *naviBar = [[DLNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight + kTopUnSafeAreaHeight + 1)];
    naviBar.navigationLeftBar = leftView;
    naviBar.navigationCenterBar = centerView;
    naviBar.navigationRightBar = rightView;
    [self.naviBar removeFromSuperview];
    self.naviBar = naviBar;
    [self.view addSubview:self.naviBar];
}

#pragma mark - ClickEvent

- (void)clickBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
