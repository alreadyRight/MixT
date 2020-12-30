//
//  DLBinaryTree.m
//  MixT
//
//  Created by 周冰烽 on 2020/9/1.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBinaryTree.h"
#import "DLQueue.h"
@interface DLBinaryTree() 

@end


@implementation DLBinaryTree

+ (instancetype)tree {
    DLBinaryTree *tree = [[DLBinaryTree alloc] init];
    return tree;
}

/// 节点数量
- (NSInteger)size { return _size; }

/// 树是否为空
- (BOOL)isEmpty { return self.size == 0; }

- (void)clear {
    _root = nil;
    _size = 0;
}

- (NSInteger)treeHeight {
    return [self treeHeightWithNode:_root];
}

- (NSInteger)treeHeightWithNode:(DLTreeNode *)treeNode {
    if (!treeNode) return 0;
    return MAX([self treeHeightWithNode:treeNode.left], [self treeHeightWithNode:treeNode.right]) + 1;
}

- (NSInteger)treeHeight1 {
    if (!_root) return 0;
    NSInteger height = 1;
    NSInteger levelSize = 1;
    DLQueue *queue = [[DLQueue alloc] init];
    [queue enQueue:_root];
    while (!queue.isEmpty) {
        levelSize--;
        DLTreeNode *node = [queue deQueue];
        if (node.left) [queue enQueue:node.left];
        if (node.right) [queue enQueue:node.right];
        if (levelSize == 0) { // levelSize为0时,表示当前层遍历完,即将进入下一层
            levelSize = queue.size;
            height++;
        }
    }
    return height;
}

- (BOOL)isCompleteBinaryTree {
    if (!_root) return NO;
    BOOL isLeaf = NO;
    DLQueue *queue = [[DLQueue alloc] init];
    [queue enQueue:_root];
    while (!queue.isEmpty) {
        DLTreeNode *node = queue.deQueue;
        if (isLeaf && !node.isLeaf) return NO; // 后面的节点都应该是叶子节点,如果不是叶子节点则返回NO
        if (node.left) [queue enQueue:node.left];
        else if (node.right) return NO; // 如果node.left为空,而node.right不为空,则返回NO
        if (node.right) [queue enQueue:node.right];
        else return YES; // 此处有两种情况, 1. node.left == nil && node.right == nil; 2. node.left != nil && node.right == nil;这两种情况都是属于完全二叉树
    }
    return YES;
}

/// 前驱节点
/// @param node 当前节点
- (DLTreeNode *)predecessor:(DLTreeNode *)node {
    if (!node) return nil;
    // node.left != null; predecessor = node.left.right.right...; 终止:right == nil
    if (node.left) {
        node = node.left;
        while (node.right) {
            node = node.right;
        }
        return node;
    }
    // node.left == null & node.parent != null; predecessor = node.parent.parent...; 终止条件: node为parent的右子树
    while (node.parent && node == node.parent.left) {
        node = node.parent;
    }
    // 此时node.parent == null || node = node.parent.right
    return node.parent;
}

/// 后继节点
/// @param node 当前节点
- (DLTreeNode *)successsor:(DLTreeNode *)node {
    if (!node) return nil;
    // node.right != null; predecessor = node.right.left.left...; 终止:left == nil
    if (node.right) {
        node = node.right;
        while (node.left) {
            node = node.left;
        }
        return node;
    }
    // node.right == null & node.parent != null; predecessor = node.parent.parent...; 终止条件: node为parent的左子树
    while (node.parent && node == node.parent.right) {
        node = node.parent;
    }
    // 此时node.parent == null || node = node.parent.right
    return node.parent;
}


/// 前序遍历
- (void)preorderTraversalBlock:(void(^)(id object, BOOL *stop))block {
    if (!block) return;
    [self preorderTraversalWithNode:_root stop:NO block:block];
}

- (void)preorderTraversalWithNode:(DLTreeNode *)node stop:(BOOL)stop block:(void(^)(id object, BOOL *stop))block {
    if (stop || !node) return;
    block(node.object, &stop);
    [self preorderTraversalWithNode:node.left stop:stop block:block];
    [self preorderTraversalWithNode:node.right stop:stop block:block];
}

/// 中序遍历
- (void)inorderTraversalBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    if (!block) return;
    [self inorderTraversalWithNode:_root stop:NO block:block];
}

- (void)inorderTraversalWithNode:(DLTreeNode *)node stop:(BOOL)stop block:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    if (stop || !node) return;
    [self inorderTraversalWithNode:node.left stop:stop block:block];
    if (stop) return;
    block(node.object, &stop);
    [self inorderTraversalWithNode:node.right stop:stop block:block];
}

/// 后序遍历
- (void)postOrderTraversalBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    if (!block) return;
    [self postOrderTraversalNode:_root stop:NO block:block];
}

- (void)postOrderTraversalNode:(DLTreeNode *)node stop:(BOOL)stop block:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    if (stop || !node) return;
    [self postOrderTraversalNode:node.left stop:stop block:block];
    [self postOrderTraversalNode:node.right stop:stop block:block];
    if (stop) return;
    block(node.object, &stop);
}

- (void)levelOrderTraversalBlock:(BOOL (^)(id _Nonnull, BOOL * _Nonnull))block {
    if (!_root || !block) return;
    DLQueue *queue = [[DLQueue alloc] init];
    [queue enQueue:_root];
    while (!queue.isEmpty) {
        DLTreeNode *node = [queue deQueue];
        BOOL isStop = block(node.object, &isStop);
        if (isStop) return;
        if (node.left) [queue enQueue:node.left];
        if (node.right) [queue enQueue:node.right];
    }
}

#pragma mark -
#pragma mark - DLBinarySearchTree

- (id)left:(DLTreeNode *)node {
    return node.left;
}

- (id)right:(DLTreeNode *)node {
    return node.right;
}

- (id)string:(DLTreeNode *)node {
    return node;
}

- (id)root {
    return _root;
}

@end
