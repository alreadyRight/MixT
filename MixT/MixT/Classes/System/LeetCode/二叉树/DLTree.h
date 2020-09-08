//
//  DLTree.h
//  MixT
//
//  Created by 周冰烽 on 2020/9/1.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLTree : NSObject

@property(nonatomic, assign) NSInteger val;

@property(nonatomic, strong) NSMutableArray<DLTree *> * children;

@end

NS_ASSUME_NONNULL_END
