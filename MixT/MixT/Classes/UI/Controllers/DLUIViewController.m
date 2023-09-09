//
//  DLUIViewController.m
//  整理
//
//  Created by 周冰烽 on 2020/6/2.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLUIViewController.h"
#import "DLMainTableViewCell.h"

#define CellID @"UITableViewCellID"
@interface DLUIViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) UITableView * tableView;

@property(nonatomic, strong) NSArray * dataSource;

@end

@implementation DLUIViewController

- (void)setupUI {
    [super setupUI];
    self.dataSource = @[@"弹出框相关", @"地图相关", @"webview", @"inputView"];
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
            vc = [[NSClassFromString(@"DLAlertDemoController") alloc] init];
            break;
        case 1:
            vc = [[NSClassFromString(@"DLMapListViewController") alloc] init];
            break;
        case 2:
            vc = [[NSClassFromString(@"DLWebViewController") alloc] init];
            break;
        case 3:
            vc = [[NSClassFromString(@"DLTextInputViewController") alloc] init];
            break;
        default:
            vc = [[NSClassFromString(@"DLAlertDemoController") alloc] init];
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
