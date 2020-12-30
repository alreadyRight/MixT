//
//  DLBalanceBinarySearchTree.m
//  MixT
//
//  Created by 周冰烽 on 2020/9/20.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBalanceBinarySearchTree.h"

@implementation DLBalanceBinarySearchTree

- (void)rotateRoot:(DLTreeNode *)r
                 b:(DLTreeNode *)b c:(DLTreeNode *)c
                 d:(DLTreeNode *)d
                 e:(DLTreeNode *)e f:(DLTreeNode *)f {
    d.parent = r.parent;
    if ([r isLeftChild]) r.parent.left = d;
    else if ([r isRightChild]) r.parent.right = d;
    else _root = d;
    
    b.right = c;
    if (!c) c.parent = b;
    
    f.left = e;
    if (!e) e.parent = f;
    
    d.left = b;
    b.parent = d;
    d.right = f;
    f.parent = d;
}

/// 对节点进行左旋转
/// @param grand 节点
- (void)rotateLeftNode:(DLTreeNode *)grand {
    DLTreeNode *parent = grand.right;
    DLTreeNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    [self afterRotateGrand:grand parent:parent child:child];
}

/// 对节点进行右旋转
/// @param grand 节点
- (void)rotateRightNode:(DLTreeNode *)grand {
    DLTreeNode *parent = grand.left;
    DLTreeNode *child = parent.right;
    grand.left = child;
    parent.right = grand;
    [self afterRotateGrand:grand parent:parent child:child];
}

- (void)afterRotateGrand:(DLTreeNode *)grand parent:(DLTreeNode *)parent child:(DLTreeNode *)child {
    // 更新parent的父节点
    parent.parent = grand.parent;
    if ([grand isLeftChild]) {
        grand.parent.left = parent;
    } else if ([grand isRightChild]) {
        grand.parent.right = parent;
    } else {
        _root = parent;
    }
    
    // 更新child的父节点
    if(child) child.parent = grand;
    
    // 更新grand的父节点
    grand.parent = parent;
}

@end
