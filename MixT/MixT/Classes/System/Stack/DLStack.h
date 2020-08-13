//
//  DLStack.h
//  MixT
//
//  Created by 周冰烽 on 2020/8/13.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLStack : NSObject

/// 栈的长度
- (NSInteger)size;

/// 栈是否为空
- (BOOL)isEmpty;

/// 入栈
/// @param object 入栈元素
- (void)push:(id __nullable)object;

/// 出栈,返回出栈元素
- (id __nullable)pop;

/// 查看栈顶元素
- (id __nullable)peek;

@end

NS_ASSUME_NONNULL_END
