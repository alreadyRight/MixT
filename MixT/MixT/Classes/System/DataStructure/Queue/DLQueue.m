//
//  DLQueue.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/14.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLQueue.h"
#import "DLLinkList.h"


@interface DLQueue()

@property(nonatomic, strong) DLLinkList * list;

@end

@implementation DLQueue

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

/// 入队
/// @param element 入队元素
- (void)enQueue:(id __nullable)element {
    [self.list addObject:element];
}

/// 出队
-(id __nullable)deQueue {
    return [self.list removeWithIndex:0];
}

/// 队头元素
-(id __nullable)front {
    return [self.list getWithIndex:0];
}

@end
