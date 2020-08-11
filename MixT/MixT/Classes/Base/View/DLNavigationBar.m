//
//  DLNavigationBar.m
//  整理
//
//  Created by 周冰烽 on 2020/6/3.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLNavigationBar.h"
#import "UIColor+DLAddtion.h"
@interface DLNavigationBar()

@property(nonatomic, weak) UIView * unAreaView;

@property(nonatomic, weak) UIView * navigationBar;

@end

@implementation DLNavigationBar

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // 安全区域
    UIView *unAreaView = [[UIView alloc] init];
    unAreaView.backgroundColor = [UIColor navigationColor];
    [self addSubview:unAreaView];
    [unAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(kTopUnSafeAreaHeight);
    }];
    self.unAreaView = unAreaView;
    // 导航栏交互区
    UIView *navigationBar = [[UIView alloc] init];
    navigationBar.backgroundColor = [UIColor navigationColor];
    [self addSubview:navigationBar];
    [navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(unAreaView.mas_bottom);
        make.height.mas_equalTo(kNavigationBarHeight);
    }];
    self.navigationBar = navigationBar;
    
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor = [UIColor lineColor].CGColor;
    bottomLayer.frame = CGRectMake(0, kTopUnSafeAreaHeight + kNavigationBarHeight, kScreenWidth, 0.3);
    [self.layer addSublayer:bottomLayer];
    
}

- (void)setNavigationLeftBar:(UIView *)navigationLeftBar {
    [self.navigationBar addSubview:navigationLeftBar];
    [navigationLeftBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationBar).offset(10);
        make.centerY.equalTo(self.navigationBar);
        make.width.mas_equalTo(navigationLeftBar.width);
        make.height.mas_equalTo(navigationLeftBar.height);
    }];
}

- (void)setNavigationRightBar:(UIView *)navigationRightBar {
    [self.navigationBar addSubview:navigationRightBar];
    [navigationRightBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationBar).offset(10);
        make.centerY.equalTo(self.navigationBar);
        make.width.mas_equalTo(navigationRightBar.width);
        make.height.mas_equalTo(navigationRightBar.height);
    }];
}

- (void)setNavigationCenterBar:(UIView *)navigationCenterBar {
    [self.navigationBar addSubview:navigationCenterBar];
    [navigationCenterBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navigationBar);
        make.centerY.equalTo(self.navigationBar).offset(-2.5);
    }];
}

@end
