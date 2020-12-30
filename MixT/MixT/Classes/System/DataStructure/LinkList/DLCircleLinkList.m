//
//  DLCircleLinkList.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/12.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLCircleLinkList.h"
#import "DLNode.h"

#define ELEMENT_NOT_FOUND (-1)

@interface DLCircleLinkList ()

@property(nonatomic, strong) DLNode * first;

@property(nonatomic, strong) DLNode * last;

@property(nonatomic, assign) NSInteger size;

@end

@implementation DLCircleLinkList

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
        if (self.size == 0) {
            // 链表中没有元素时
            DLNode *node = [[DLNode alloc] initWithPrev:nil Object:object next:nil];
            node.prev = node;
            node.next = node;
            self.first = self.last = node;
        } else {
            DLNode *oldLast = self.last;
            self.last = [[DLNode alloc] initWithPrev:oldLast Object:object next:self.first];
            oldLast.next = self.last;
            self.first.prev = self.last;
        }
    } else {
        if (index == 0) {
            // 插入头节点
            DLNode *oldFirst = self.first;
            DLNode *newFirst = [[DLNode alloc] initWithPrev:oldFirst.prev Object:object next:oldFirst];
            oldFirst.prev.next = newFirst;
            oldFirst.prev = newFirst;
            self.first = newFirst;
        } else {
            // 其他节点
            DLNode *node = [self getNodeWithIndex:index];
            DLNode *prev = node.prev;
            DLNode *newNode = [[DLNode alloc] initWithPrev:prev Object:object next:node];
            prev.next = newNode;
            node.prev = newNode;
        }
    }
    self.size++;
}

- (id)removeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index actionName:__func__];
    DLNode *node = [self getNodeWithIndex:index];
    
    if (self.size == 1) {
        self.first = nil;
        self.last = nil;
    } else {
        // 因为是环形链表,则prev和next都不可能为空
        DLNode *prev = node.prev;
        DLNode *next = node.next;
        prev.next = next;
        node.prev = prev;
        if (node == self.first) self.first = next;
        if (node == self.last) self.last = prev;
    }
    
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
