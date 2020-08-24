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

@end
