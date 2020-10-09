//
//  DLAVLTree.m
//  MixT
//
//  Created by 周冰烽 on 2020/9/7.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAVLTree.h"
#import "DLAVLTreeNode.h"
@implementation DLAVLTree

#pragma mark - Overried

/// 创建节点(AVL树创建DLAVLTreeNode节点)
/// @param object 节点数据
/// @param parent 父节点
- (DLTreeNode *)createNodeWithObject:(id)object parent:(DLTreeNode *)parent {
    return [DLAVLTreeNode AVLTreeWithObject:object node:parent];
}

/// 平衡操作
/// @param node 添加的节点
- (void)afterAddObjectWithNode:(DLTreeNode *)node {
    while ((node = node.parent) != nil) {
        if ([self isBalanceWithNode:node]) {
            // 平衡, 更新高度
            [self updateHeightWithNode:node];
        } else {
            // 不平衡, 恢复平衡
            [self rebalance2Node:node];
            break;
        }
    }
}

/// 平衡操作
/// @param node 删除节点
- (void)afterRemoveNode:(DLTreeNode *)node {
    while ((node = node.parent) != nil) {
        if ([self isBalanceWithNode:node]) {
            [self updateHeightWithNode:node];
        } else {
            [self rebalanceNode:node];
        }
    }
}

- (void)rotateRoot:(DLTreeNode *)r b:(DLTreeNode *)b c:(DLTreeNode *)c d:(DLTreeNode *)d e:(DLTreeNode *)e f:(DLTreeNode *)f {
    [super rotateRoot:r b:b c:c d:d e:e f:f];
    [self updateHeightWithNode:b];
    [self updateHeightWithNode:f];
    [self updateHeightWithNode:d];
}

- (void)afterRotateWithGrand:(DLTreeNode *)grand parent:(DLTreeNode *)parent child:(DLTreeNode *)child {
    [super afterRotateGrand:grand parent:parent child:child];
    // 更新grand的高度和parent高度,在一开始grand的树种,grand和parent的高度发生了改变
    [self updateHeightWithNode:grand];
    [self updateHeightWithNode:parent];
}


#pragma mark - private

/// 判断节点是否平衡
/// @param node 当前节点
- (BOOL)isBalanceWithNode:(DLTreeNode *)node {
    return labs([(DLAVLTreeNode *)node balanceFactor]) <= 1;
}

/// 更新节点的height
/// @param node 当前节点
- (void)updateHeightWithNode:(DLTreeNode *)node {
    [(DLAVLTreeNode *)node updateHeight];
}

- (void)rebalanceNode:(DLTreeNode *)grand {
    DLTreeNode *parent = [(DLAVLTreeNode *)grand tallerChild];
    DLTreeNode *node = [(DLAVLTreeNode *)parent tallerChild];
    if ([parent isLeftChild]) {
        if ([node isLeftChild]) { // LL
            [self rotateRoot:grand b:node c:node.right d:parent e:parent.right f:grand];
        } else { // LR
            [self rotateRoot:grand b:parent c:node.left d:node e:node.right f:grand];
        }
    } else {
        if ([node isLeftChild]) { // RL
            [self rotateRoot:grand b:grand c:node.left d:node e:node.right f:parent];
        } else { // RR
            [self rotateRoot:grand b:grand c:parent.left d:parent e:node.left f:node];
        }
    }
}

/// 使当前节点恢复平衡
/// @param grand 当前节点
- (void)rebalance2Node:(DLTreeNode *)grand {
    DLTreeNode *parent = [(DLAVLTreeNode *)grand tallerChild];
    DLTreeNode *node = [(DLAVLTreeNode *)parent tallerChild];
    if ([parent isLeftChild]) {
        if ([node isLeftChild]) { // LL
            // 对grand进行右旋转
            [self rotateRightNode:grand];
        } else { // LR
            // 先对parent进行左旋转
            [self rotateLeftNode:parent];
            // 再对grand进行右旋转
            [self rotateRightNode:grand];
        }
    } else {
        if ([node isLeftChild]) { // RL
            // 先对parent进行右旋转
            [self rotateRightNode:parent];
            // 再对grand进行左旋转
            [self rotateLeftNode:grand];
        } else { // RR
            // 对grand进行左旋转
            [self rotateLeftNode:grand];
        }
    }
}



@end
