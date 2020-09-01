//
//  DLBinarySearchTree.h
//  MixT
//
//  Created by 周冰烽 on 2020/8/18.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLCompareProtocol.h"

#import "DLBinaryTree.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLBinarySearchTree : DLBinaryTree 

+ (instancetype)tree;

/// 传入比较器(遵循DLCompareProtocol协议的)
/// @param comparator 比较器
+ (instancetype)treeWithComparator:(_Nullable id<DLCompareProtocol>)comparator;

/// 实例方法
/// @param compareBlock 重写object1和object2的比较方法
+ (instancetype)treeWithCompareBlock:(int(^)(id object1, id object2))compareBlock;

/// 添加树节点
/// @param object 节点内容
- (void)addObject:(id)object;

/// 树是否包含某节点
/// @param object 节点内容
- (BOOL)containsObject:(id)object;

/// 删除树节点
/// @param object 节点内容
- (void)removeObject:(id)object;

@end

NS_ASSUME_NONNULL_END
