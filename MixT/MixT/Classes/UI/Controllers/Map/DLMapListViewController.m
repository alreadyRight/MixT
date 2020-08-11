//
//  DLMapListViewController.m
//  整理
//
//  Created by 周冰烽 on 2020/7/27.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLMapListViewController.h"
#import "DLMainTableViewCell.h"
#import "BMKMapShowViewController.h"
#define MapCellID @"mapCellID"
@interface DLMapListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray * dataSource;

@end

@implementation DLMapListViewController

- (void)setupUI {
    [super setupUI];
    self.title = @"地图相关";
    [super setupTitleAndBackNaviBar];
    
    self.dataSource = @[
        @{
            @"title": @"百度地图", @"data": @[
                    @{@"name": @"创建地图"},
                    @{@"name": @"地图交互"},
                    @{@"name": @"地图绘制"},
                    @{@"name": @"地图检索"},
                    @{@"name": @"路线规划"},
                    @{@"name": @"地址导航"},
                    @{@"name": @"地图工具"}
            ]},
        @{@"title": @"高德地图", @"data": @[
                  @{@"name": @"创建地图"},
                  @{@"name": @"地图交互"},
                  @{@"name": @"地图绘制"},
                  @{@"name": @"地图数据"},
                  @{@"name": @"出行规划"},
                  @{@"name": @"计算工具"},
                  @{@"name": @"实用工具"},
        ]}
    ];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, kNavigationBarHeight + kTopUnSafeAreaHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[DLMainTableViewCell class] forCellReuseIdentifier:MapCellID];
    [self.view insertSubview:tableView atIndex:0];
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataSource[section][@"title"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataSource[section][@"data"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MapCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = self.dataSource[indexPath.section][@"data"];
    if (arr.count > 0) {
        cell.titleText = arr[indexPath.row][@"name"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BMKMapShowViewController *mapShowVC = [[BMKMapShowViewController alloc] init];
            mapShowVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:mapShowVC animated:YES completion:nil];
        }
    }
}

@end
