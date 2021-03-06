//
//  DLSingleLinkList.m
//  整理
//
//  Created by 周冰烽 on 2020/8/7.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLSingleLinkList.h"
#import "DLSingleNode.h"
#define ELEMENT_NOT_FOUND (-1)

@interface DLSingleLinkList()

@property(nonatomic, strong) DLSingleNode * first;

@property(nonatomic, assign) NSInteger size;

@end

@implementation DLSingleLinkList

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
    if (index == 0) {
        self.first = [[DLSingleNode alloc] initWithObject:object next:self.first];
    } else {
        // 获取index前面的节点
        DLSingleNode *prev = [self getNodeWithIndex:index - 1];
        // 要插入的节点,next为index前节点的后一个节点
        // index前一个节点的后一个节点为新的节点
        prev.next = [[DLSingleNode alloc] initWithObject:object next:prev.next];
    }
    _size++;
}

- (id)removeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index actionName:__func__];
    DLSingleNode *node = self.first;
    if (index == 0) {
        // 首节点删除, 相当于first节点 = first的下个节点
        self.first = self.first.next;
    } else {
        // 获取要删除节点的上一个节点
        DLSingleNode *prev = [self getNodeWithIndex:index - 1];
        // 要删除的节点
        node = prev.next;
        // 上一个节点的下一个 等于 当前节点的下一个 , 则删掉了当前节点
        prev.next = node.next;
    }
    self.size--;
    return node.object;
}

- (void)clear {
    // 清空时不能简单的将first置为nil,如果置为nil,则会释放first,堆空间释放之后无法再次赋值其内部元素
    self.first = nil;
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
    DLSingleNode *node = self.first;
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
#pragma mark - private

- (DLSingleNode *)getNodeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index actionName:__func__];
    DLSingleNode *node = self.first;
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

- (DLSingleNode *)first {
    if (!_first) {
        _first = [[DLSingleNode alloc] initWithObject:nil next:nil];
    }
    return _first;
}

@end
