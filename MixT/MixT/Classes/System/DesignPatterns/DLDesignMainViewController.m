//
//  DLDesignMainViewController.m
//  MixT
//
//  Created by 周冰烽 on 2020/12/29.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLDesignMainViewController.h"
#import "DLMainTableViewCell.h"

#define CellID @"DesignTableViewCellID"

@interface DLDesignMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UITableView * tableView;

@property(nonatomic, strong) NSArray * dataSource;

@end

@implementation DLDesignMainViewController

- (void)setupUI {
    [super setupUI];
    self.title = @"设计模式";
    [super setupTitleAndBackNaviBar];
    self.dataSource = @[@"简单工厂模式", @"策略模式", @"单一职责原则", @"开放-封闭原则", @"依赖倒转原则", @"装饰模式", @"代理模式", @"工厂方法模式", @"原型模式",
                        @"模板方法模式", @"迪米特法则", @"外观模式", @"建造者模式", @"观察者模式", @"抽象工厂模式", @"状态模式", @"适配器模式", @"备忘录模式",
                        @"组合模式", @"迭代器模式", @"单例模式", @"桥接模式", @"命令模式", @"职责链模式", @"中介者模式", @"享元模式", @"解释器模式", @"访问者模式"];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, kNavigationBarHeight + kTopUnSafeAreaHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight - kTabbarHeight - kBottomUnSafeAreaHeight);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[DLMainTableViewCell class] forCellReuseIdentifier:CellID];
    [self.view insertSubview:tableView atIndex:0];
}

#pragma mark - UITableViewDelegate && dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleText = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLBaseViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [[NSClassFromString(@"DLCalculateViewController") alloc] init];
            break;
        case 1:
            vc = [[NSClassFromString(@"DLStrategyPatternViewController") alloc] init];
            break;
        default:
            vc = [[NSClassFromString(@"DLCalculateViewController") alloc] init];
            break;
        
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
