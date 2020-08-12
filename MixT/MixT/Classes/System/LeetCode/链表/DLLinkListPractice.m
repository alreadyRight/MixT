//
//  DLLinkListPractice.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/12.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLLinkListPractice.h"

@interface ListNode : NSObject

@property(nonatomic, assign) int val;

@property(nonatomic, strong) ListNode * next;

@end

@implementation ListNode

- (instancetype)initWithVal:(int)val {
    if (self = [super init]) {
        self.val = val;
    }
    return self;
}

@end

@implementation DLLinkListPractice

/// 2. 两数相加
/// https://leetcode-cn.com/problems/add-two-numbers/
/*
    输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
    输出：7 -> 0 -> 8
    原因：342 + 465 = 807
 */
- (ListNode *)addTwoNumbersWithL1:(ListNode *)l1 l2:(ListNode *)l2 {
    ListNode *dummary = [[ListNode alloc] initWithVal:0];
    ListNode *p = l1;
    ListNode *q = l2;
    ListNode *curr = dummary;
    int count = 0;
    while (p != nil || q != nil) {
        int x = (p == nil) ? 0 : p.val;
        int y = (q == nil) ? 0 : q.val;
        int sum = count + x + y;
        curr.next = [[ListNode alloc] initWithVal:(sum % 10)];
        count = sum / 10;
        curr = curr.next;
        if (p != nil) p = p.next;
        if (q != nil) q = q.next;
    }
    // 最后判断是否溢出
    if (count > 0) {
        curr.next = [[ListNode alloc] initWithVal:count];
    }
    
    return dummary.next;
}

- (void)test {
    ListNode *node1 = [[ListNode alloc] initWithVal:2];
    ListNode *node2 = [[ListNode alloc] initWithVal:7];
    ListNode *node3 = [[ListNode alloc] initWithVal:5];
    ListNode *node4 = [[ListNode alloc] initWithVal:8];
    node1.next = node2;
    node2.next = node3;
    node3.next = node4;
    node4.next = nil;
    // [2, 7, 5, 8]
    
    ListNode *node5 = [[ListNode alloc] initWithVal:6];
    ListNode *node6 = [[ListNode alloc] initWithVal:9];
    ListNode *node7 = [[ListNode alloc] initWithVal:2];
    ListNode *node8 = [[ListNode alloc] initWithVal:9];
    ListNode *node9 = [[ListNode alloc] initWithVal:9];
    node5.next = node6;
    node6.next = node7;
    node7.next = node8;
    node8.next = node9;
    node9.next = nil;
    // [6, 9, 2, 9, 9]
    
    // [2, 7, 5, 8]
    // [6, 9, 2, 9, 9]
    // [8, 6, 8, 7, 0, 1]
    ListNode *res = [self addTwoNumbersWithL1:node1 l2:node5];
    NSLog(@"%@", res);
}

@end
