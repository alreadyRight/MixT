//
//  DLBinarySearchTree.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/18.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBinarySearchTree.h"
#import "DLTreeNode.h"
@interface DLBinarySearchTree ()

@property(nonatomic, assign) NSInteger size;

@property(nonatomic, strong) id<DLCompareProtocol> comparator;

@property(nonatomic, copy) int(^DLComparatorBlock)(id object1, id object2);

/// 根节点
@property(nonatomic, strong) DLTreeNode * root;

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

/// 节点数量
- (NSInteger)size {
    return self.size;
}

/// 树是否为空
- (BOOL)isEmpty {
    return self.size == 0;
}
/// 添加树节点
/// @param object 节点内容
- (void)addObject:(id)object {
    if (self.root == nil) {
        self.root = [DLTreeNode nodeWithObject:object parent:nil];
        self.size++;
        return;
    }
    
    /**
    *  添加节点步骤
    *  1. 找到父节点parent
    *  2. 创建新的节点 node
    *  3. parent.left = node 或者 parent.right = node
    */
    
    // 1. 找到父节点parent
    DLTreeNode * parent = self.root;
    DLTreeNode * node = self.root;
    NSInteger cmp = 0;
    while (node != nil) {
        cmp = [self compareWithObject1:object object2:node.object];
        parent = node;
        if (cmp > 0) {
            node = node.right;
        } else if (cmp < 0) {
            node = node.left;
        } else {
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
    
    self.size++;
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

/// 树是否包含某节点
/// @param object 节点内容
- (BOOL)containsObject:(id)object {
    return YES;
}

@end
