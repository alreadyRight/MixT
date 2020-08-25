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
@interface DLSystemViewController ()

@end

@implementation DLSystemViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    DLLinkListPractice *llp = [[DLLinkListPractice alloc] init];
//    [llp test];
    
//    DLStackPractice *stackP = [[DLStackPractice alloc] init];
//    [stackP test];
    
    DLBinarySearchTree *bst = [DLBinarySearchTree tree];
    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100 };
    int len = sizeof(data) / sizeof(int);
    for (int i = 0; i < len; i++) {
        [bst addObject:@(data[i])];
    }
    [MJBinaryTrees println:bst];
    
    [bst preorderTraversalBlock:^(id  _Nonnull object, BOOL * _Nonnull stop) {
//        if ([object isEqual:@"33"]) {
//            *stop = YES;
//        } else {
//            NSLog(@"%@",object);
//        }
        NSLog(@"%@", object);
    }];
    
    NSLog(@"====================");
    
    [bst inorderTraversalBlock:^(id  _Nonnull object, BOOL * _Nonnull stop) {
        NSLog(@"%@", object);
    }];
    NSLog(@"====================");
    
    [bst postOrderTraversalBlock:^(id  _Nonnull object, BOOL * _Nonnull stop) {
        NSLog(@"%@", object);
    }];
    NSLog(@"====================");
    
    [bst levelOrderTraversalBlock:^BOOL(id  _Nonnull object, BOOL * _Nonnull stop) {
        NSLog(@"%@", object);
        return NO;
    }];
    NSLog(@"====================");
}

@end
