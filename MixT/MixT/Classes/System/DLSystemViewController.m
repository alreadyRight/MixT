//
//  DLSystemViewController.m
//  整理
//
//  Created by 周冰烽 on 2020/6/2.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLSystemViewController.h"
#import "DLLinkListPractice.h"
#import "DLStackPractice.h"
#import "DLBinarySearchTree.h"
#import "MJBinaryTrees.h"
#import "DLMainTableViewCell.h"

#define CellID @"SystemTableViewCellID"

@interface DLSystemViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UITableView * tableView;

@property(nonatomic, strong) NSArray * dataSource;

@end

@implementation DLSystemViewController

- (void)setupUI {
    [super setupUI];
    self.dataSource = @[@"设计模式"];
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
            vc = [[NSClassFromString(@"DLDesignMainViewController") alloc] init];
            break;
        
    }
    [self.navigationController pushViewController:vc animated:YES];
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    DLLinkListPractice *llp = [[DLLinkListPractice alloc] init];
////    [llp test];
//
////    DLStackPractice *stackP = [[DLStackPractice alloc] init];
////    [stackP test];
//
//    DLBinarySearchTree *bst = [DLBinarySearchTree tree];
//    NSArray *arr = [NSArray arrayWithObjects:@11, @32, @7, @33, @2, @88, @23, @45, @42, @65, nil];
//    for (NSString *str in arr) {
//        [bst addObject:str];
//    }
//    [MJBinaryTrees println:bst];
//
////    [bst preorderTraversalBlock:^(id  _Nonnull object, BOOL * _Nonnull stop) {
////        NSLog(@"%@", object);
////    }];
//
////    NSLog(@"====================");
////
////    [bst inorderTraversalBlock:^(id  _Nonnull object, BOOL * _Nonnull stop) {
////        NSLog(@"%@", object);
////    }];
////    NSLog(@"====================");
////
//    [bst postOrderTraversalBlock:^(id  _Nonnull object, BOOL * _Nonnull stop) {
//        NSLog(@"%@", object);
//    }];
////    NSLog(@"====================");
////
////    [bst levelOrderTraversalBlock:^BOOL(id  _Nonnull object, BOOL * _Nonnull stop) {
////        NSLog(@"%@", object);
////        return NO;
////    }];
////    NSLog(@"====================");
//}

@end
