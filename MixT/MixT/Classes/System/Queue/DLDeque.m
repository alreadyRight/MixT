//
//  DLDeque.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/14.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLDeque.h"
#import "DLLinkList.h"

@interface DLDeque ()

@property(nonatomic, strong) DLLinkList * list;

@end

@implementation DLDeque

- (instancetype)init {
    if (self = [super init]) {
        self.list = [[DLLinkList alloc] init];
    }
    return self;
}

/// 队列长度
- (NSInteger)size {
    return self.list.size;
}

/// 队列是否为空
- (BOOL)isEmpty {
    return self.list.isEmpty;
}

/// 入队(队头)
/// @param element 入队元素
- (void)enQueueFront:(id __nullable)element {
    [self.list addObject:element index:0];
}

/// 入队(队尾)
/// @param element 入队元素
- (void)enQueueRear:(id __nullable)element {
    [self.list addObject:element];
}

/// 出队(队头)
- (id __nullable)deQueueFront {
    return [self.list removeWithIndex:0];
}

/// 出队(队尾)
- (id __nullable)deQueueRear {
    return [self.list removeWithIndex:self.list.size - 1];
}

/// 队头元素
- (id __nullable)front {
    return [self.list getWithIndex:0];;
}

/// 队尾元素
- (id __nullable)rear {
    return [self.list getWithIndex:self.list.size - 1];
}

@end
