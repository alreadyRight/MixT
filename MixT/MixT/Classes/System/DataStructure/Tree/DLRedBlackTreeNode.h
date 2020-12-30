//
//  DLRedBlackTreeNode.h
//  MixT
//
//  Created by 周冰烽 on 2020/9/20.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLRedBlackTreeNode : DLTreeNode

@property(nonatomic, assign) BOOL color;

+ (instancetype)RBNodeWithObject:(id)object parent:(DLTreeNode *)parent;

@end

NS_ASSUME_NONNULL_END
