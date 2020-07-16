//
//  DLAlertDemoController.m
//  整理
//
//  Created by 周冰烽 on 2020/7/3.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAlertDemoController.h"
#import "DLMainTableViewCell.h"
#import "DLCustomPresentationController.h"
#import "DLTestViewController.h"

#import "DLAnimationFading.h"
#import "DLAnimationLeft.h"
#import "DLAnimationRight.h"
#import "DLAnimationTop.h"
#import "DLAnimationBottom.h"
#import "DLAnimationCenterFromTop.h"
#import "DLAnimationCenterFromBottom.h"
#import "DLDateAnimation.h"

#import "DLDateSelectController.h"

#define AlertCellID @"alertCellID"
@interface DLAlertDemoController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray * dataSource;


@end

@implementation DLAlertDemoController

- (void)setupUI {
    [super setupUI];
    self.title = @"弹出框相关";
    [super setupTitleAndBackNaviBar];
    self.dataSource = @[
                        @{
                            @"title": @"基础弹窗", @"data": @[
                                        @{@"name": @"Left Translate"},
                                        @{@"name": @"Right Translate"},
                                        @{@"name": @"Top Translate"},
                                        @{@"name": @"Bottom Translate"},
                                        @{@"name": @"Center Fading"},
                                        @{@"name": @"Center FromTop"},
                                        @{@"name": @"Center FromBottom"}
                                    ]},
                        @{@"title": @"选择框", @"data": @[
                                        @{@"name": @"Single Select"},
                                        @{@"name": @"Double Select"},
                                        @{@"name": @"Three Select"},
                                        @{@"name": @"Date Select"},
                                        @{@"name": @"Time Select"},
                                        @{@"name": @"Address Select"}
                                    ]},
                        @{@"title": @"双选框", @"data": @[]},
                        @{@"title": @"双选框", @"data": @[]},
                        @{@"title": @"双选框", @"data": @[]},
                        @{@"title": @"双选框", @"data": @[]}
                    ];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, kNavigationBarHeight + kTopUnSafeAreaHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[DLMainTableViewCell class] forCellReuseIdentifier:AlertCellID];
    [self.view insertSubview:tableView atIndex:0];
}


#pragma mark - UITableViewDelegate && dataSource

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
    DLMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AlertCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = self.dataSource[indexPath.section][@"data"];
    if (arr.count > 0) {
        cell.titleText = arr[indexPath.row][@"name"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            DLTestViewController *testVC = [[DLTestViewController alloc] init];
            DLCustomPresentationController *customPresentationVC = [[DLCustomPresentationController alloc]initWithPresentedViewController:testVC presentingViewController:self];
            testVC.transitioningDelegate = customPresentationVC;
            switch (indexPath.row) {
                case 0:
                    customPresentationVC.animation = [[DLAnimationLeft alloc] init];
                    break;
                case 1:
                    customPresentationVC.animation = [[DLAnimationRight alloc] init];
                    break;
                case 2:
                    customPresentationVC.animation = [[DLAnimationTop alloc] init];
                    break;
                case 3:
                    customPresentationVC.animation = [[DLAnimationBottom alloc] init];
                    break;
                case 4:
                    customPresentationVC.animation = [[DLAnimationFading alloc] init];
                    break;
                case 5:
                    customPresentationVC.animation = [[DLAnimationCenterFromTop alloc] init];
                    break;
                default:
                    customPresentationVC.animation = [[DLAnimationCenterFromBottom alloc] init];
                    break;
            }
            [self presentViewController:testVC animated:YES completion:nil];
        });
    } else if (indexPath.section == 1) {
        if (indexPath.row == 3) {
            DLDateSelectController *timeVC = [[DLDateSelectController alloc] init];
            DLCustomPresentationController *presentingVC = [[DLCustomPresentationController alloc] initWithPresentedViewController:timeVC presentingViewController:self];
            timeVC.transitioningDelegate = presentingVC;
            presentingVC.animation = [[DLDateAnimation alloc] init];
            [self presentViewController:timeVC animated:YES completion:nil];
        }
    }
}




@end
