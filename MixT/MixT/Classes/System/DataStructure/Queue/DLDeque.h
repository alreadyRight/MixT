//
//  DLDeque.h
//  MixT
//
//  Created by 周冰烽 on 2020/8/14.
//  Copyright © 2020 周冰烽. All rights reserved.
//  双端队列

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLDeque : NSObject

/// 队列长度
- (NSInteger)size;

/// 队列是否为空
- (BOOL)isEmpty;

/// 入队(队头)
/// @param element 入队元素
- (void)enQueueFront:(id __nullable)element;

/// 入队(队尾)
/// @param element 入队元素
- (void)enQueueRear:(id __nullable)element;

/// 出队(队头)
- (id __nullable)deQueueFront;

/// 出队(队尾)
- (id __nullable)deQueueRear;

/// 队头元素
- (id __nullable)front;

/// 队尾元素
- (id __nullable)rear;

@end

NS_ASSUME_NONNULL_END
