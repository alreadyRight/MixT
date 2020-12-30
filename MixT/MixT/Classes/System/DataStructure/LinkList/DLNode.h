//
//  DLNode.h
//  整理
//
//  Created by 周冰烽 on 2020/8/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLNode : NSObject

@property(nonatomic, strong) id object;

@property(nonatomic, strong) DLNode * next;

@property(nonatomic, strong) DLNode * prev;


- (instancetype)initWithPrev:(DLNode * __nullable)prev Object:(id __nullable)object next:(DLNode * __nullable)next;

@end

NS_ASSUME_NONNULL_END
