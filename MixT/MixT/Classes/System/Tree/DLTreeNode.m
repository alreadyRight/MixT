//
//  DLTreeNode.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/18.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLTreeNode.h"

@implementation DLTreeNode

+ (instancetype)nodeWithObject:(id)object parent:(DLTreeNode * _Nullable)parent {
    DLTreeNode *node = [[self alloc] init];
    node.object = object;
    node.parent = parent;
    return node;
}

- (DLTreeNode *)sibling {
    if ([self isLeftChild]) return self.parent.right;
    if ([self isRightChild]) return self.parent.left;
    return nil;
}

- (BOOL)hasTwoChild {
    return self.left && self.right;
}

- (BOOL)isLeaf {
    return !self.left && !self.right;
}

- (BOOL)isLeftChild {
    return (self.parent) && (self == self.parent.left);
}

- (BOOL)isRightChild {
    return (self.parent) && (self == self.parent.right);
}

@end
