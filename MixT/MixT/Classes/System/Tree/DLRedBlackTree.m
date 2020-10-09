//
//  DLRedBlackTree.m
//  MixT
//
//  Created by 周冰烽 on 2020/9/20.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLRedBlackTree.h"
#import "DLRedBlackTreeNode.h"
@implementation DLRedBlackTree

static BOOL RED = NO;

static BOOL BLACK = YES;

- (DLTreeNode *)colorNode:(DLTreeNode *)node color:(BOOL)color {
    if (!node) return nil;
    ((DLRedBlackTreeNode *)node).color = color;
    return node;
}

- (DLTreeNode *)redNode:(DLTreeNode *)node {
    return [self colorNode:node color:RED];
}

- (DLTreeNode *)blackNode:(DLTreeNode *)node {
    return [self colorNode:node color:BLACK];
}

- (BOOL)colorOfNode:(DLTreeNode *)node {
    return node ? ((DLRedBlackTreeNode *)node).color : BLACK;
}

- (BOOL)isBlack:(DLTreeNode *)node {
    return [self colorOfNode:node] == BLACK;
}

- (BOOL)isRed:(DLTreeNode *)node {
    return [self colorOfNode:node] == RED;
}

#pragma mark - Overried

- (DLTreeNode *)createNodeWithObject:(id)object parent:(DLTreeNode *)parent {
    return [DLRedBlackTreeNode RBNodeWithObject:object parent:parent];
}

- (void)afterAddObjectWithNode:(DLTreeNode *)node {
    DLTreeNode *parent = node.parent;
    if (!parent) {
        [self blackNode:node]; // 如果是根节点直接染黑就可以
        return;
    }
    
    if([self isBlack:parent]) return; // 如果父节点是黑色,不用做任何处理
    
    // 叔父节点
    DLTreeNode *uncle = node.parent.sibling;
    
    // 祖父节点染红
    DLTreeNode *grand = [self redNode:parent.parent];
    
    // 叔父节点为红色,B树上溢
    if ([self isRed:uncle]) {
        // 父节点和叔父节点染成黑色
        [self blackNode:parent];
        [self blackNode:uncle];
        // 把祖父节点当做是新添加的节点(染红上面生成grand已做)
        [self afterAddObjectWithNode:grand];
        return;
    }
    
    // 叔父节点不是红色
    if (parent.isLeftChild) { // L
        if (node.isLeftChild) { // LL
            // parent染成黑色,grand染成红色(已做),grand右旋
            [self blackNode:parent];
        } else { // LR
            // node染成黑色,grand染成红色(已做),parent左旋,grand右旋
            [self blackNode:node];
            [self rotateLeftNode:parent];
        }
        [self rotateRightNode:grand];
    } else { // R
        if (node.isLeftChild) { //RL
            // node染成黑色,grand染成红色(已做),parent右旋,grand左旋
            [self redNode:node];
            [self rotateRightNode:parent];
        } else { //RR
            // parent染成黑色,grand染成红色(已做),grand左旋
            [self blackNode:parent];
        }
        [self rotateLeftNode:grand];
    }
}

- (void)afterRemoveNode:(DLTreeNode *)node {
    // 如果删掉的节点是红色,不用做任何处理,或者用于取代node的子节点是红色,将node染黑
    if ([self isRed:node]) {
        [self blackNode:node];
        return;
    }
    
    DLTreeNode *parent = node.parent;
    // 如果删除的是根节点,不用作处理
    if (parent == nil) return;
    
    // 删除节点是黑色叶子节点,且取代节点不为红色
    // 获取兄弟节点[下溢]
    // 判断被删除的节点是左还是右
    BOOL left = parent.left == nil || node.isLeftChild;
    DLTreeNode *sibling = left ? parent.right : parent.left;
    if (left) {
        // 被删除节点在左边, 兄弟节点在右边
        if ([self isRed:sibling]) { // 兄弟节点为红色
            // 将兄弟节点染黑,父节点染成红色
            [self blackNode:sibling];
            [self redNode:parent];
            [self rotateLeftNode:parent];
            // 更换兄弟
            sibling = parent.right;
        }
        // 以下是兄弟节点为黑色情况
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) { // 兄弟节点没有一个红色子节点
            // 1. 存储变量:父节点是否是黑色
            BOOL parentIsBlack = [self isBlack:parent];
            // 2. 父节点向下与兄弟节点合并
            // 3. 兄弟节点染红,父节点染黑
            [self redNode:sibling];
            [self blackNode:parent];
            // 4. 父节点如果是黑色, 把父节点当做删除节点来操作
            if (parentIsBlack) {
                [self afterRemoveNode:parent];
            }
        } else {
            // 兄弟节点至少有一个红色节点
            if ([self isBlack:sibling.left]) { // 兄弟节点左边是黑色
                // 1. 对兄弟进行右旋转
                [self rotateRightNode:sibling];
                // 2. 更换sibling
                sibling = parent.right;
            }
            // sibling节点上去之前跟随parent的颜色
            [self colorNode:sibling color:[self colorOfNode:parent]];
            // 独立的两个节点染成黑色
            [self blackNode:sibling.right];
            [self blackNode:parent];
            // 统一处理, 对parent进行右旋转
            [self rotateRightNode:parent];
        }
    } else {
        // 被删除节点在右边,兄弟节点在左边
        if ([self isRed:sibling]) {
            // 兄弟节点是红色
            // 兄弟节点染成黑色,父节点染成红色
            [self blackNode:sibling];
            [self redNode:parent];
            [self rotateRightNode:parent];
            // 更换兄弟
            sibling = parent.left;
        }
        // 兄弟节点是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有一个红色子节点
            // 判断父节点是否是黑色
            BOOL parentIsBlack = [self isBlack:parent];
            // 1. 父节点向下跟兄弟节点合并
            // 2. 兄弟节点染红,父节点染黑
            [self redNode:sibling];
            [self blackNode:parent];
            if (parentIsBlack) {
                // 如果是黑色的话,把父节点当做删除节点来操作
                [self afterRemoveNode:parent];
            }
        } else {
            // 兄弟节点至少有一个红色子节点
            if ([self isBlack:sibling.left]) { // 兄弟节点左边是黑色
                // 对兄弟节点进行左旋转
                [self rotateLeftNode:sibling];
                // 特殊情况,更换sibling
                sibling = parent.left;
            }
            // sibling节点上去之前跟随parent的颜色
            [self colorNode:sibling color:[self colorOfNode:parent]];
            // 独立的两个节点染成黑色
            [self blackNode:sibling.left];
            [self blackNode:parent];
            // 统一处理,对parent进行右旋转
            [self rotateRightNode:parent];
        }
    }
    
}

@end
