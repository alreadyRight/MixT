//
//  DLBinaryTree.h
//  MixT
//
//  Created by 周冰烽 on 2020/9/1.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLTreeNode.h"
#import "MJBinaryTreeInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLBinaryTree : NSObject <MJBinaryTreeInfo> {
    @protected
    DLTreeNode *_root;
    NSInteger _size;
}

+ (instancetype)tree;

/// 节点数量
- (NSInteger)size;

/// 树是否为空
- (BOOL)isEmpty;

/// 清空树
- (void)clear;

/// 树的高度(递归)
- (NSInteger)treeHeight;

/// 树的高度(迭代)
- (NSInteger)treeHeight1;

/// 是否为完全二叉树
- (BOOL)isCompleteBinaryTree;

/// 前驱节点
/// @param node 当前节点
- (DLTreeNode *)predecessor:(DLTreeNode *)node;

/// 后继节点
/// @param node 当前节点
- (DLTreeNode *)successsor:(DLTreeNode *)node;



/// 前序遍历
/// @param block 遍历block
- (void)preorderTraversalBlock:(void(^)(id object, BOOL *stop))block;

/// 中序遍历
/// @param block 遍历block
- (void)inorderTraversalBlock:(void(^)(id object, BOOL *stop))block;

/// 后序遍历
/// @param block 遍历block
- (void)postOrderTraversalBlock:(void(^)(id object, BOOL *stop))block;

/// 层序遍历
/// @param block 遍历block
- (void)levelOrderTraversalBlock:(BOOL(^)(id object, BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
