//
//  DLBinarySearchTree.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/18.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBinarySearchTree.h"
#import "DLTreeNode.h"
#import "DLQueue.h"
@interface DLBinarySearchTree ()

@property(nonatomic, strong) id<DLCompareProtocol> comparator;

@property(nonatomic, copy) int(^DLComparatorBlock)(id object1, id object2);

@end

@implementation DLBinarySearchTree {
    DLTreeNode *_root;
    NSInteger _size;
}

+ (instancetype)tree {
    return [self treeWithComparator:nil];
}

+ (instancetype)treeWithComparator:(_Nullable id<DLCompareProtocol>)comparator {
    DLBinarySearchTree *bst = [[self alloc] init];
    bst.comparator = comparator;
    return bst;
}

+ (instancetype)treeWithCompareBlock:(int (^)(id _Nonnull, id _Nonnull))compareBlock {
    DLBinarySearchTree *bst = [[self alloc] init];
    bst.DLComparatorBlock = compareBlock;
    return bst;
}

/// 节点数量
- (NSInteger)size {
    return _size;
}

/// 树是否为空
- (BOOL)isEmpty {
    return self.size == 0;
}
/// 添加树节点
/// @param object 节点内容
- (void)addObject:(id)object {
    if (!object) return;
    if (!_root) {
        _root = [DLTreeNode nodeWithObject:object parent:nil];
        _size++;
        return;
    }
    
    /**
     *  添加节点步骤
     *  1. 找到父节点parent
     *  2. 创建新的节点 node
     *  3. parent.left = node 或者 parent.right = node
     */
    
    // 1. 找到父节点parent
    DLTreeNode * parent = _root;
    DLTreeNode * node = _root;
    NSInteger cmp = 0;
    while (node) {
        cmp = [self compareWithObject1:object object2:node.object];
        parent = node;
        if (cmp > 0) {
            node = node.right;
        } else if (cmp < 0) {
            node = node.left;
        } else {
            node.object = object;
            return;
        }
    }
    // 2. 创建新的节点 node
    DLTreeNode *newNode = [DLTreeNode nodeWithObject:object parent:parent];
    
    // 3. parent.left = node 或者 parent.right = node
    if (cmp > 0) {
        parent.right = newNode;
    } else {
        parent.left = newNode;
    }
    
    _size++;
}

- (NSInteger)compareWithObject1:(id)object1 object2:(id)object2 {
    if (self.DLComparatorBlock) {
        return self.DLComparatorBlock(object1, object2);
    } else {
        if (self.comparator) {
            return [self.comparator compareWithObject1:object1 object2:object2];
        } else {
            return (int)[object1 compare:object2];
        }
    }
}

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




/// 树是否包含某节点
/// @param object 节点内容
- (BOOL)containsObject:(id)object {
    return YES;
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
    return node.object;
}

- (id)root {
    return _root;
}

@end
