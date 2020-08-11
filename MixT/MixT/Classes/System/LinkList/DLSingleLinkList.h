//
//  DLSingleLinkList.h
//  整理
//
//  Created by 周冰烽 on 2020/8/7.
//  Copyright © 2020 周冰烽. All rights reserved.
//  单向链表的简单实现

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLSingleLinkList : NSObject

/// 获取index位置的节点存储的元素
/// @param index 位置
- (id)getWithIndex:(NSInteger)index;

/// 更改index位置节点存储的元素
/// @param index 位置
/// @param object 要存储的元素
- (id)setWithIndex:(NSInteger)index object:(id)object;

/// 在index位置添加object元素
/// @param object 元素
/// @param index 位置
- (void)addObject:(id)object index:(NSInteger)index;

/// 在链表最后位置添加元素
/// @param object 元素
- (void)addObject:(id)object;

/// 删除index位置的元素
/// @param index 位置
- (id)removeWithIndex:(NSInteger)index;

/// 查看object的位置
/// @param object 元素
- (NSInteger)indexOfObject:(id)object;

/// 清空链表
- (void)clear;

/// 链表长度
- (NSInteger)size;

/// 链表是否为空
- (BOOL)isEmpty;

/// 链表是否包含object元素
/// @param object 元素
- (BOOL)containsObject:(id)object;


@end

NS_ASSUME_NONNULL_END
