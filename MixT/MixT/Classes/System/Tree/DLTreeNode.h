//
//  DLTreeNode.h
//  MixT
//
//  Created by 周冰烽 on 2020/8/18.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLTreeNode : NSObject

@property(nonatomic, strong) id object;

@property(nonatomic, strong) DLTreeNode  * _Nullable left;

@property(nonatomic, strong) DLTreeNode * _Nullable right;

@property(nonatomic, weak) DLTreeNode * _Nullable parent;

/// 度为2的节点
@property(nonatomic, assign) BOOL hasTwoChild;

/// 是否为叶子节点
@property(nonatomic, assign) BOOL isLeaf;

/// 是否为父节点的左子树
- (BOOL)isLeftChild;

/// 是否为父节点的右子树
- (BOOL)isRightChild;

+ (instancetype)nodeWithObject:(id)object parent:(DLTreeNode * _Nullable)parent;

@end

NS_ASSUME_NONNULL_END
