//
//  DLTreeNode.h
//  MixT
//
//  Created by 周冰烽 on 2020/8/18.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLTreeNode : NSObject

@property(nonatomic, strong) id object;

@property(nonatomic, strong) DLTreeNode * left;

@property(nonatomic, strong) DLTreeNode * right;

@property(nonatomic, weak) DLTreeNode * parent;

+ (instancetype)nodeWithObject:(id)object parent:(DLTreeNode * _Nullable)parent;

@end

NS_ASSUME_NONNULL_END
