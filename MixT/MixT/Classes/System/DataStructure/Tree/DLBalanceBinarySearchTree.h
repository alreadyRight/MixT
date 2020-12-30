//
//  DLBalanceBinarySearchTree.h
//  MixT
//
//  Created by 周冰烽 on 2020/9/20.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBinarySearchTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLBalanceBinarySearchTree : DLBinarySearchTree

- (void)rotateRoot:(DLTreeNode *)r
                 b:(DLTreeNode *)b c:(DLTreeNode *)c
                 d:(DLTreeNode *)d
                 e:(DLTreeNode *)e f:(DLTreeNode *)f;

/// 对节点进行左旋转
/// @param grand 节点
- (void)rotateLeftNode:(DLTreeNode *)grand;

/// 对节点进行右旋转
/// @param grand 节点
- (void)rotateRightNode:(DLTreeNode *)grand;


- (void)afterRotateGrand:(DLTreeNode *)grand parent:(DLTreeNode *)parent child:(DLTreeNode *)child;

@end

NS_ASSUME_NONNULL_END
