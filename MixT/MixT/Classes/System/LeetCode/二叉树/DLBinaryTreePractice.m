//
//  DLBinaryTreePractice.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/31.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBinaryTreePractice.h"
#import "DLTreeNode.h"
#import "DLStack.h"
#import "DLQueue.h"
#import "DLLinkList.h"
@implementation DLBinaryTreePractice {
    NSMutableArray *_list;
}


/// 94.二叉树的中序遍历(递归) https://leetcode-cn.com/problems/binary-tree-inorder-traversal/
/// @param root 根节点
- (NSMutableArray *)inorderTraversalWithRoot:(DLTreeNode *)root {
    _list = [NSMutableArray array];
    if (!root) return _list;
    [self inorderTraversalWithRoot:root.left];
    [_list addObject:root.object];
    [self inorderTraversalWithRoot:root.right];
    return _list;
}

/// 94.二叉树的中序遍历(迭代) https://leetcode-cn.com/problems/binary-tree-inorder-traversal/
/// @param root 根节点
- (NSMutableArray *)inorderTraversal1WithRoot:(DLTreeNode *)root {
    NSMutableArray *array = [NSMutableArray array];
    if (!root) return array;
    DLStack *stack = [[DLStack alloc] init];
    DLTreeNode *curr = root;
    while (!stack.isEmpty && curr) {
        while (curr) {
            [stack push:curr];
            curr = curr.left;
        }
        DLTreeNode *node = [stack pop];
        [array addObject:node.object];
        if (!node.right) [stack push:node.right];
    }
    return array;
}

/// 94.二叉树的层序遍历(迭代): https://leetcode-cn.com/problems/binary-tree-level-order-traversal/
/// @param root 根节点
- (NSMutableArray *)levelOrderTraversalWithRoot:(DLTreeNode *)root {
    NSMutableArray *res = [NSMutableArray array];
    DLQueue *queue = [[DLQueue alloc] init];
    [queue enQueue:root];
    while (!queue.isEmpty) {
        NSMutableArray *levelRes = [NSMutableArray array];
        NSInteger size = queue.size;
        while (size > 0) {
            DLTreeNode *node = queue.deQueue;
            [levelRes addObject:node.object];
            if (node.left) [queue enQueue:node.left];
            if (node.right) [queue enQueue:node.right];
            size--;
        }
        [res addObject:levelRes];
    }
    return res;
}

/// 102.二叉树的最大深度(递归): https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/
/// @param root 根节点
- (NSInteger)maxDepthWithRoot:(DLTreeNode *)root {
    if (!root) return 0;
    return MAX([self maxDepthWithRoot:root.left], [self maxDepthWithRoot:root.right]);
}

/// 102.二叉树的最大深度(迭代): https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/
/// @param root 根节点
- (NSInteger)maxDepth1WithRoot:(DLTreeNode *)root {
    if (!root) return 0;
    DLQueue *queue = [[DLQueue alloc] init];
    [queue enQueue:root];
    NSInteger depth = 0;
    while (!queue.isEmpty) {
        NSInteger size = queue.size;
        while (size > 0) {
            DLTreeNode *node = queue.deQueue;
            if (node.left) [queue enQueue:node.left];
            if (node.right) [queue enQueue:node.left];
            size--;
        }
        depth++;
    }
    return depth;
}

/// 107.二叉树的层次遍历II(迭代): https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/submissions/
/// @param root 根节点
- (NSMutableArray *)levelOrderBottomWithRoot:(DLTreeNode *)root {
    DLLinkList *res = [[DLLinkList alloc] init];
    if (!root) return [NSMutableArray array];
    DLQueue *queue = [[DLQueue alloc] init];
    [queue enQueue:root];
    while (!queue.isEmpty) {
        NSInteger size = queue.size;
        NSMutableArray *levelRes = [NSMutableArray array];
        while (size > 0) {
            DLTreeNode *node = queue.deQueue;
            [levelRes addObject:node.object];
            if (node.left) [queue enQueue:node.left];
            if (node.right) [queue enQueue:node.right];
            size--;
        }
        [res addObject:levelRes index:0];
    }
    NSMutableArray *result = [NSMutableArray array];
    while (!res.isEmpty) {
        [result addObject:[res removeWithIndex:0]];
    }
    return result;
}

/// 前序遍历(递归): https://leetcode-cn.com/problems/binary-tree-preorder-traversal/
/// @param root 根节点
- (NSMutableArray *)preorderTraversalWithRoot:(DLTreeNode *)root {
    _list = [NSMutableArray array];
    if (!root) return _list;
    [_list addObject:root.object];
    [self preorderTraversalWithRoot:root.left];
    [self preorderTraversalWithRoot:root.right];
    return _list;
}

/// 前序遍历(迭代): https://leetcode-cn.com/problems/binary-tree-preorder-traversal/
/// @param root 根节点
- (NSMutableArray *)preorderTraversal1WithRoot:(DLTreeNode *)root {
    NSMutableArray *res = [NSMutableArray array];
    if (!root) return res;
    DLStack *stack = [[DLStack alloc] init];
    [stack push:root];
    while (!stack.isEmpty) {
        DLTreeNode *node = stack.pop;
        [res addObject:node.object];
        if (node.right) [stack push:node.right];
        if (node.left) [stack push:node.left];
    }
    return res;
}

/// 前序遍历(递归): https://leetcode-cn.com/problems/binary-tree-preorder-traversal/
/// @param root 根节点
- (NSMutableArray *)postOrderTraversalWithRoot:(DLTreeNode *)root {
    _list = [NSMutableArray array];
    if (!root) return _list;
    [self preorderTraversalWithRoot:root.left];
    [self preorderTraversalWithRoot:root.right];
    [_list addObject:root.object];
    return _list;
}

/// 前序遍历(迭代): https://leetcode-cn.com/problems/binary-tree-preorder-traversal/
/// @param root 根节点
- (NSMutableArray *)postOrderTraversal1WithRoot:(DLTreeNode *)root {
    DLLinkList *res = [[DLLinkList alloc] init];
    if (!root) return [NSMutableArray array];
    DLStack *stack = [[DLStack alloc] init];
    [stack push:root];
    while (!stack.isEmpty) {
        DLTreeNode *node = stack.pop;
        [res addObject:node.object index:0];
        if (node.left) [stack push:node.left];
        if (node.right) [stack push:node.right];
    }
    NSMutableArray *result = [NSMutableArray array];
    while (!res.isEmpty) {
        [result addObject:[res removeWithIndex:0]];
    }
    return result;
}

/// 翻转二叉树(前序遍历,中序遍历,后序遍历,层序遍历): https://leetcode-cn.com/problems/invert-binary-tree/
/// @param root 根节点
- (DLTreeNode *)invertTree:(DLTreeNode *)root {
//    return [self preoderTree:root];
//    return [self inorderTree:root];
//    return [self postOrderTree:root];
    return [self levelOrderTree:root];
}

- (DLTreeNode *)preoderTree:(DLTreeNode *)root {
    if (!root) return root;
    DLTreeNode *temp = root.left;
    root.left = temp.right;
    root.right = temp;
    [self preoderTree:root.left];
    [self preoderTree:root.right];
    return root;
}

- (DLTreeNode *)inorderTree:(DLTreeNode *)root {
    if (!root) return root;
    [self inorderTree:root.left];
    DLTreeNode *temp = root.left;
    root.left = temp.right;
    root.right = temp;
    // 此处左子树和右子树已调换位置,所以传的为左子树
    [self inorderTree:root.left];
    return root;
}

- (DLTreeNode *)postOrderTree:(DLTreeNode *)root {
    if (!root) return root;
    [self preoderTree:root.left];
    [self preoderTree:root.right];
    DLTreeNode *temp = root.left;
    root.left = temp.right;
    root.right = temp;
    return root;
}

- (DLTreeNode *)levelOrderTree:(DLTreeNode *)root {
    if (!root) return root;
    DLQueue *queue = [[DLQueue alloc] init];
    [queue enQueue:root];
    while (!queue.isEmpty) {
        DLTreeNode *node = queue.deQueue;
        DLTreeNode *temp = node.left;
        node.left = node.right;
        node.right = temp;
        if (node.left) [queue enQueue:node.left];
        if (node.right) [queue enQueue:node.right];
    }
    return root;
}

/// 662.二叉树最大宽度: https://leetcode-cn.com/problems/maximum-width-of-binary-tree/
/// @param root 根节点
- (NSInteger)widthOfBinaryTree:(DLTreeNode *)root {
    if (!root) return 0;
    NSInteger res = 0;
    // 1.层序遍历
    // 2.list存储每个添加进去的position,left = parent * 2, right = parent * 2 + 1
    // 3.每层的长度就为list的最后一个元素 - 第一个元素 + 1
    DLQueue *queue = [[DLQueue alloc] init];
    NSMutableArray *list = [NSMutableArray array];
    [list addObject:@1];
    [queue enQueue:root];
    while (!queue.isEmpty) {
        NSInteger size = queue.size;
        while (size > 0) {
            DLTreeNode *node = queue.deQueue;
            [list removeObjectAtIndex:0];
            NSInteger size = [list[0] integerValue];
            if (node.left) {
                [queue enQueue:node.left];
                [list addObject:@(size * 2)];
            }
            if (node.right) {
                [queue enQueue:node.right];
                [list addObject:@(size * 2 + 1)];
            }
            size--;
        }
        res = MAX(res, [list[list.count - 1] integerValue] - [list[0] integerValue] + 1);
    }
    return res;
}


@end
