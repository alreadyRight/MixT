//
//  DLAVLTreeNode.h
//  MixT
//
//  Created by 周冰烽 on 2020/9/3.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLAVLTreeNode : DLTreeNode

@property(nonatomic, assign) NSInteger height;

+ (instancetype)AVLTreeWithObject:(id)object node:(DLTreeNode *)parent;

- (NSInteger)balanceFactor;

- (void)updateHeight;

- (DLTreeNode *)tallerChild;

@end

NS_ASSUME_NONNULL_END
