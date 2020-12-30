//
//  DLLinkList.h
//  整理
//
//  Created by 周冰烽 on 2020/8/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//  双向链表

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLLinkList : NSObject

/// 获取index位置的节点存储的元素
/// @param index 位置
- (id __nullable)getWithIndex:(NSInteger)index;

/// 更改index位置节点存储的元素
/// @param index 位置
/// @param object 要存储的元素
- (id __nullable)setWithIndex:(NSInteger)index object:(id __nullable)object;

/// 在index位置添加object元素
/// @param object 元素
/// @param index 位置
- (void)addObject:(id __nullable)object index:(NSInteger)index;

/// 在链表最后位置添加元素
/// @param object 元素
- (void)addObject:(id __nullable)object;

/// 删除index位置的元素
/// @param index 位置
- (id __nullable)removeWithIndex:(NSInteger)index;

/// 查看object的位置
/// @param object 元素
- (NSInteger)indexOfObject:(id __nullable)object;

/// 清空链表
- (void)clear;

/// 链表长度
- (NSInteger)size;

/// 链表是否为空
- (BOOL)isEmpty;

/// 链表是否包含object元素
/// @param object 元素
- (BOOL)containsObject:(id __nullable)object;

@end

NS_ASSUME_NONNULL_END
