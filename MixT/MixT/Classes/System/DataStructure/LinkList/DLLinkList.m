//
//  DLLinkList.m
//  整理
//
//  Created by 周冰烽 on 2020/8/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//  

#import "DLLinkList.h"
#import "DLNode.h"
#define ELEMENT_NOT_FOUND (-1)

@interface DLLinkList()

@property(nonatomic, strong) DLNode * first;

@property(nonatomic, strong) DLNode * last;

@property(nonatomic, assign) NSInteger size;

@end


@implementation DLLinkList

#pragma mark -
#pragma mark - public

- (instancetype)init {
    if (self = [super init]) {
        self.size = 0;
    }
    return self;
}

- (NSInteger)size {
    return _size;
}

- (void)addObject:(id)object {
    [self addObject:object index:_size];
}

- (void)addObject:(id)object index:(NSInteger)index {
    [self rangeCheckForAddWithIndex:index actionName:__func__];
    if (index == self.size) { // 插入最后一个元素
        if (self.size == 0) { // 链表为空时
            self.first = [[DLNode alloc] initWithPrev:nil Object:object next:nil];
            self.last = self.first;
        } else {
            DLNode *oldLast = [self getNodeWithIndex:self.size - 1];
            self.last = [[DLNode alloc] initWithPrev:oldLast Object:object next:nil];
            oldLast.next = self.last;
        }
    } else {
        if (index == 0) { // 插入头节点
            DLNode *oldFirst = self.first;
            DLNode *node = [[DLNode alloc] initWithPrev:nil Object:object next:self.first];
            oldFirst.prev = node;
            self.first = node;
        } else {
            DLNode *next = [self getNodeWithIndex:index];
            DLNode *prev = next.prev;
            DLNode *newNode = [[DLNode alloc] initWithPrev:prev Object:object next:next];
            next.prev = newNode;
            prev.next = newNode;
        }
    }
    self.size++;
}

- (id)removeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index actionName:__func__];
    DLNode *node = [self getNodeWithIndex:index];
    
    if (index == 0) self.first = node.next; // 删除首节点
    else node.prev = node.next;
    
    if (index == self.size - 1) self.last = node.prev; // 删除尾节点
    else node.next.prev = node.prev;
    
    self.size--;
    return node.object;
}

- (void)clear {
    self.first = nil;
    self.last = nil;
    _size = 0;
}

- (id)setWithIndex:(NSInteger)index object:(id)object {
    id old = [self getNodeWithIndex:index].object;
    [self getNodeWithIndex:index].object = object;
    return old;
}

- (id)getWithIndex:(NSInteger)index {
    return [self getNodeWithIndex:index].object;
}

- (NSInteger)indexOfObject:(id)object {
    DLNode *node = self.first;
    // 判断节点中存储的是否是空元素
    if (object == nil) {
        // 遍历链表
        for (NSInteger i = 0; i < self.size; i++) {
            if (node.object == nil) return i;
            node = node.next;
        }
    } else {
        for (NSInteger i = 0; i < self.size; i++) {
            if ([node.object isEqual:object]) return i;
            node = node.next;
        }
    }
    // 如果上面的遍历中没有找到,则链表中不含object元素,返回-1代表没有找到
    return ELEMENT_NOT_FOUND;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (BOOL)containsObject:(id)object {
    return [self indexOfObject:object] != ELEMENT_NOT_FOUND;
}


#pragma mark -
#pragma mark - Private

- (DLNode *)getNodeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index actionName:__func__];
    DLNode *node = self.first;
    for (NSInteger i = 0; i < index; i++) {
        node = node.next;
    }
    return node;
}

- (void)rangeCheckWithIndex:(NSInteger)index actionName:(const char *)actionName {
    if (index >= _size || index < 0) [self outOfBoundsWithIndex:index actionName:actionName];
}

- (void)rangeCheckForAddWithIndex:(NSInteger)index actionName:(const char *)actionName {
    if (index > _size || index < 0) [self outOfBoundsWithIndex:index actionName:actionName];
}

- (void)outOfBoundsWithIndex:(NSInteger)index actionName:(const char *)actionName {
    NSString *name = [NSString stringWithCString:actionName encoding:NSUTF8StringEncoding];
    @throw [[NSException alloc] initWithName:name reason:[NSString stringWithFormat:@"index:%zd beyond bounds [0 ..%zd]",index,_size] userInfo:nil];
}

#pragma mark -
#pragma mark - LazyLoad

- (DLNode *)first {
    if (!_first) {
        _first = [[DLNode alloc] initWithPrev:nil Object:nil next:nil];
    }
    return _first;
}

- (DLNode *)last {
    if (!_last) {
        _last = [[DLNode alloc] initWithPrev:nil Object:nil next:nil];
    }
    return _last;
}

@end
