//
//  DLQueue.h
//  MixT
//
//  Created by 周冰烽 on 2020/8/14.
//  Copyright © 2020 周冰烽. All rights reserved.
//  基础队列

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLQueue : NSObject

/// 队列长度
- (NSInteger)size;

/// 队列是否为空
- (BOOL)isEmpty;

/// 入队
/// @param element 入队元素
- (void)enQueue:(id __nullable)element;

/// 出队
-(id __nullable)deQueue;

/// 队头元素
-(id __nullable)front;

@end

NS_ASSUME_NONNULL_END
