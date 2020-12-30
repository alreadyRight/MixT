//
//  DLStack.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/13.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLStack.h"
#import "DLLinkList.h"

@interface DLStack ()

@property(nonatomic, strong) DLLinkList * list;

@end

@implementation DLStack

- (instancetype)init {
    if (self = [super init]) {
        self.list = [[DLLinkList alloc] init];
    }
    return self;
}

- (NSInteger)size {
    return self.list.size;
}

- (BOOL)isEmpty {
    return self.list.isEmpty;
}

- (void)push:(id __nullable)object {
    [self.list addObject:object];
}

- (id __nullable)pop {
    return [self.list removeWithIndex:self.list.size - 1];
}

- (id __nullable)peek {
    return [self.list getWithIndex:self.list.size - 1];
}

@end
