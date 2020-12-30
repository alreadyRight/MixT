//
//  DLTreeSet.h
//  MixT
//
//  Created by 周冰烽 on 2020/10/9.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLCompareProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLTreeSet : NSObject

+ (instancetype)set;

/// 传入比较器(遵循DLCompareProtocol协议的)
/// @param comparator 比较器
+ (instancetype)setWithComparator:(_Nullable id<DLCompareProtocol>)comparator;

/// 集合大小
- (NSInteger)size;

/// 集合是否为空
- (BOOL)isEmpty;

/// 清空集合
- (void)clear;

/// 是否包含元素
/// @param object 元素
- (BOOL)containsObject:(NSObject *)object;

/// 添加元素
/// @param object 元素
- (void)addObject:(NSObject *)object;

/// 删除元素
/// @param object 元素
- (void)removeObject:(NSObject *)object;

/// 遍历
/// @param block 遍历结果
- (void)traversalBlock:(void(^)(id object, BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
