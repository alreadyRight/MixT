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

@implementation DLBinarySearchTree

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

/// 添加树节点
/// @param object 节点内容
- (void)addObject:(id)object {
    if (!object) return;
    if (!_root) {
        _root = [self createNodeWithObject:object parent:nil];
        _size++;
        [self afterAddObjectWithNode:_root];
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
    DLTreeNode *newNode = [self createNodeWithObject:object parent:parent];
    
    // 3. parent.left = node 或者 parent.right = node
    if (cmp > 0) {
        parent.right = newNode;
    } else {
        parent.left = newNode;
    }
    _size++;
    [self afterAddObjectWithNode:newNode];
}

- (DLTreeNode *)createNodeWithObject:(id)object parent:(DLTreeNode * _Nullable)parent {
    return [DLTreeNode nodeWithObject:object parent:parent];
}

- (void)afterAddObjectWithNode:(DLTreeNode *)node {
    
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


- (void)removeObject:(id)object {
    [self removeObjectWithNode:[self nodeFromObject:object]];
}

- (void)removeObjectWithNode:(DLTreeNode *)node {
    if (!node) return;
    _size--;
    // 处理度为2的节点
    if (node.hasTwoChild) {
        // 找到前驱/后继节点
        DLTreeNode *pre = [self predecessor:node];
        // 用前驱/后继节点的值覆盖要删除节点的值
        node.object = pre.object;
        // 让删除的节点 = 前驱/后继节点的值(删除前驱/后继节点)
        node = pre;
    }
    
    // 删除度为1/0的节点
    DLTreeNode *childNode = node.left ? node.left : node.right;
    if (childNode) { // 度为1的节点
        childNode.parent = node.parent;
        if (!node.parent) _root = childNode;
        if (node == node.parent.left) node.parent.left = childNode;
        if (node == node.parent.right) node.parent.right = childNode;
    }
    else if (!node.parent) _root = nil; // node为叶子节点且为根节点
    else {
        // node为叶子节点且不为根节点
        if (node == node.parent.left) node.parent.left = nil;
        else node.parent.right = nil;
    }
    
}

- (DLTreeNode *)nodeFromObject:(id)object {
    DLTreeNode *node = _root;
    while (node) {
        NSInteger cmp = [self compareWithObject1:object object2:node.object];
        if (cmp == 0) return node;
        if (cmp > 0) node = node.right; // 值大于节点值,往右子树查找
        else node = node.left; // 值小于节点值,往左子树查找
    }
    return nil;
}

/// 树是否包含某节点
/// @param object 节点内容
- (BOOL)containsObject:(id)object {
    return [self nodeFromObject:object];
}


@end
