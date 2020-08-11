//
//  DLSingleNode.h
//  整理
//
//  Created by 周冰烽 on 2020/8/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLSingleNode : NSObject

@property(nonatomic, strong) id object;

@property(nonatomic, strong) DLSingleNode * next;

- (instancetype)initWithObject:(id __nullable)object next:(DLSingleNode * __nullable)next;

@end

NS_ASSUME_NONNULL_END
