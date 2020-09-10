//
//  DLBinaryTreeTest.m
//  MixTTests
//
//  Created by 周冰烽 on 2020/8/26.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MJBinaryTrees.h"
#import "DLBinarySearchTree.h"
#import "DLAVLTree.h"
@interface DLBinaryTreeTest : XCTestCase

@end

@implementation DLBinaryTreeTest

- (void)setUp {
//    DLBinarySearchTree *bst = [DLBinarySearchTree tree];
//    NSArray *arr = [NSArray arrayWithObjects:@11, @32, @7, @33, @2, @88, @23, @45, @42, @65, nil];
//    for (NSString *str in arr) {
//        [bst addObject:str];
//    }
//    [MJBinaryTrees println:bst];
//    [bst removeObject:@65];
//    [MJBinaryTrees println:bst];
//    [bst removeObject:@11];
//    [MJBinaryTrees println:bst];
//    [bst removeObject:@88];
//    [MJBinaryTrees println:bst];
//    NSLog(@"=============");
    DLAVLTree *avlTree = [DLAVLTree tree];
    NSArray *arr = [NSArray arrayWithObjects:@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, nil];
    for (NSString *str in arr) {
        [avlTree addObject:str];
        [MJBinaryTrees println:avlTree];
    }
    for (NSString *str in arr) {
        [avlTree removeObject:str];
        if (avlTree.root) {
            [MJBinaryTrees println:avlTree];
        }
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
