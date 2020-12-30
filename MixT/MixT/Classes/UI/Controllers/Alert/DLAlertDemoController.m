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
#import "DLAddressAnimation.h"
#import "DLAnimationInput.h"

#import "DLCustomAlertController.h"
#import "DLDateSelectController.h"
#import "DLTimeSelectController.h"
#import "DLAddressAlertController.h"
#import "DLInputViewController.h"

#import "UIViewController+DLPresent.h"

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
        @{@"title": @"选择框(非联动)", @"data": @[
                  @{@"name": @"Single Select"},
                  @{@"name": @"Double Select"},
                  @{@"name": @"Three Select"},
                  @{@"name": @"Time Select"}
        ]},
        @{@"title": @"选择框(联动)", @"data": @[
                  @{@"name": @"Date Select"},
                  @{@"name": @"Address Select"}
        ]},
        @{@"title": @"输入框", @"data": @[@{@"name": @"Alert Input"}]},
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
    DLBaseAnimation *animation = nil;
    if (indexPath.section == 0) {
        DLTestViewController *testVC = [[DLTestViewController alloc] init];
        switch (indexPath.row) {
            case 0:
                animation = [[DLAnimationLeft alloc] init];
                break;
            case 1:
                animation = [[DLAnimationRight alloc] init];
                break;
            case 2:
                animation = [[DLAnimationTop alloc] init];
                break;
            case 3:
                animation = [[DLAnimationBottom alloc] init];
                break;
            case 4:
                animation = [[DLAnimationFading alloc] init];
                break;
            case 5:
                animation = [[DLAnimationCenterFromTop alloc] init];
                break;
            default:
                animation = [[DLAnimationCenterFromBottom alloc] init];
                break;
        }
        [self presentViewController:testVC animation:animation completion:nil];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSArray *arr = @[@[@"aaa", @"bbb", @"ccc", @"ddd", @"eee"]];
            DLCustomAlertController *customAlertC = [[DLCustomAlertController alloc] init];
            customAlertC.title = @"单选框";
            customAlertC.pickerDatas = arr;
            animation = [[DLDateAnimation alloc] init];
            [self presentViewController:customAlertC animation:animation completion:nil];
        }
        if (indexPath.row == 1) {
            NSArray *arr = @[@[@"aaa", @"bbb", @"ccc", @"ddd", @"eee"],@[@"fff", @"ggg", @"hhh", @"iii", @"jjj"]];
            DLCustomAlertController *customAlertC = [[DLCustomAlertController alloc] init];
            customAlertC.title = @"双选框";
            customAlertC.pickerDatas = arr;
            animation = [[DLDateAnimation alloc] init];
            [self presentViewController:customAlertC animation:animation completion:nil];
        }
        if (indexPath.row == 2) {
            NSArray *arr = @[@[@"aaa", @"bbb", @"ccc", @"ddd", @"eee"], @[@"fff", @"ggg", @"hhh", @"iii", @"jjj"], @[@"kkk", @"lll", @"mmm", @"nnn", @"ooo"]];
            DLCustomAlertController *customAlertC = [[DLCustomAlertController alloc] init];
            customAlertC.title = @"多选框";
            customAlertC.pickerDatas = arr;
            animation = [[DLDateAnimation alloc] init];
            [self presentViewController:customAlertC animation:animation completion:nil];
        }
        if (indexPath.row == 3) {
            DLTimeSelectController *timeAlert = [[DLTimeSelectController alloc] init];
            animation = [[DLDateAnimation alloc] init];
            [self presentViewController:timeAlert animation:animation completion:nil];
            timeAlert.selectValue = ^(NSArray * _Nonnull timeArray) {
                NSLog(@"%@",timeArray);
            };
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            DLDateSelectController *dateAlert = [[DLDateSelectController alloc] init];
            animation = [[DLDateAnimation alloc] init];
            [self presentViewController:dateAlert animation:animation completion:nil];
            dateAlert.selectDate = ^(NSArray * _Nonnull dateArray) {
                NSLog(@"%@",dateArray);
            };
        }
        if (indexPath.row == 1) {
            DLAddressAlertController *addressAlertC = [[DLAddressAlertController alloc] init];
            animation = [[DLAddressAnimation alloc] init];
            [self presentViewController:addressAlertC animation:animation completion:nil];
            addressAlertC.selectValues = ^(NSArray * _Nonnull addressArray) {
                NSLog(@"%@",addressArray);
            };
        }
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            // 自定义输入框
            DLInputViewController *inputVC = [[DLInputViewController alloc] init];
            inputVC.title = @"验证码";
            animation = [[DLAnimationInput alloc] init];
            [self presentViewController:inputVC animation:animation completion:nil];
            inputVC.pinValue = ^(NSString * _Nonnull pinValue) {
                NSLog(@"%@",pinValue);
            };
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"1111" message:@"1111111" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//            [alert addAction:action];
//            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}




@end
