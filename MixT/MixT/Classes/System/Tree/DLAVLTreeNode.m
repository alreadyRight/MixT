//
//  DLAVLTreeNode.m
//  MixT
//
//  Created by 周冰烽 on 2020/9/3.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAVLTreeNode.h"

@implementation DLAVLTreeNode

+ (instancetype)AVLTreeWithObject:(id)object node:(DLTreeNode *)parent {
    DLAVLTreeNode *node = [super nodeWithObject:object parent:parent];
    node.height = 1;
    return node;
}

- (DLTreeNode *)tallerChild {
    NSInteger leftHeight = self.left ? ((DLAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((DLAVLTreeNode *)self.right).height : 0;
    if (leftHeight > rightHeight) return self.left;
    if (leftHeight < rightHeight) return self.right;
    return [self isLeftChild] ? self.left : self.right;
}

- (NSInteger)balanceFactor {
    NSInteger leftHeight = self.left ? ((DLAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((DLAVLTreeNode *)self.right).height : 0;
    return leftHeight - rightHeight;
}

- (void)updateHeight {
    NSInteger leftHeight = self.left ? ((DLAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((DLAVLTreeNode *)self.right).height : 0;
    self.height = 1 + MAX(leftHeight, rightHeight);
}

@end
