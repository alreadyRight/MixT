//
//  DLTreeSet.m
//  MixT
//
//  Created by 周冰烽 on 2020/10/9.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLTreeSet.h"
#import "DLRedBlackTree.h"

@interface DLTreeSet()

@property(nonatomic, strong) DLRedBlackTree * tree;

@end

@implementation DLTreeSet

#pragma mark - 初始化方法

+ (instancetype)set {
    return [self setWithComparator:nil];
}

+ (instancetype)setWithComparator:(id<DLCompareProtocol>)comparator {
    DLTreeSet *set = [[self alloc] init];
    set.tree = [DLRedBlackTree treeWithComparator:comparator];
    return set;
}

#pragma mark - public

- (NSInteger)size {
    return self.tree.size;
}

- (BOOL)isEmpty {
    return self.tree.isEmpty;
}

- (void)clear {
    [self.tree clear];
}

- (BOOL)containsObject:(NSObject *)object {
    return [self.tree containsObject:object];
}

- (void)addObject:(NSObject *)object {
    [self.tree addObject:object];
}

- (void)removeObject:(NSObject *)object {
    [self.tree removeObject:object];
}

- (void)traversalBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    [self.tree inorderTraversalBlock:block];
}



@end
