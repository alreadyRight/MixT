//
//  DLSingleCircleList.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/12.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLSingleCircleList.h"
#import "DLSingleNode.h"

#define ELEMENT_NOT_FOUND (-1)

@interface DLSingleCircleList()

@property(nonatomic, assign) NSInteger size;

@property(nonatomic, strong) DLSingleNode * first;

@end

@implementation DLSingleCircleList

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
    
    // 与单向链表的区别在于最后的last.next需指向first节点
    
    if (index == 0) {
        DLSingleNode *newFirst = [[DLSingleNode alloc] initWithObject:object next:self.first];
        DLSingleNode *last = self.size == 0 ? newFirst : [self getNodeWithIndex:self.size - 1];
        last.next = newFirst;
        self.first = newFirst;
    } else {
        // 此处不用再次处理last节点, 因为链表初次插入时已实现环状,及last.next -> first,则如果index为尾部元素,下面prev.next为first节点
        DLSingleNode *prev = [self getNodeWithIndex:index - 1];
        prev.next = [[DLSingleNode alloc] initWithObject:object next:prev.next];
    }
    _size++;
}

- (id)removeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index actionName:__func__];
    DLSingleNode *node = self.first;
    if (index == 0) {
        if (self.size == 1) self.first = nil;
        else {
            DLSingleNode *last = [self getNodeWithIndex:self.size - 1];
            self.first = self.first.next;
            last = self.first;
        }
    } else {
        // 此处不用再次处理last节点, 因为链表初次插入时已实现环状,及last.next -> first,则如果index为尾部元素,下面node.next为first节点
        DLSingleNode *prev = [self getNodeWithIndex:index - 1];
        node = prev.next;
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
