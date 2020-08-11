//
//  DLNode.m
//  整理
//
//  Created by 周冰烽 on 2020/8/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLNode.h"

@implementation DLNode

- (instancetype)initWithPrev:(DLNode *)prev Object:(id)object next:(DLNode *)next {
    if (self = [super init]) {
        self.prev = prev;
        self.object = object;
        self.next = next;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DLNode 释放");
}

@end
