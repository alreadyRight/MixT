//
//  DLRedBlackTreeNode.m
//  MixT
//
//  Created by 周冰烽 on 2020/9/20.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLRedBlackTreeNode.h"

@implementation DLRedBlackTreeNode

+ (instancetype)RBNodeWithObject:(id)object parent:(DLTreeNode *)parent {
    DLRedBlackTreeNode *node = [super nodeWithObject:object parent:parent];
    node.color = NO; // 默认是红色
    return node;
}

- (NSString *)description {
    NSString *str = @"";
    if (!self.color) {
        str = @"R_";
    }
    return [NSString stringWithFormat:@"%@%@",str, self.object];
}

@end
