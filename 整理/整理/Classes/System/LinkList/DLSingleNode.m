//
//  DLSingleNode.m
//  整理
//
//  Created by 周冰烽 on 2020/8/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLSingleNode.h"

@implementation DLSingleNode

- (instancetype)initWithObject:(id)object next:(DLSingleNode *)next {
    if (self = [super init]) {
        self.object = object;
        self.next = next;
    }
    return self;
}


@end
