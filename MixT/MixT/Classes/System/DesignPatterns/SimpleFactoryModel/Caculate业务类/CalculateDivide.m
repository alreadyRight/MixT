//
//  CalculateDivide.m
//  设计模式-01
//
//  Created by 周冰烽 on 2020/12/22.
//  除法类

#import "CalculateDivide.h"

@implementation CalculateDivide

- (CGFloat)calculateToolResult {
    if (self.num2 == 0) {
        NSLog(@"除数不能为0");
        return 0;
    }
    return self.num1 / self.num2;
}

@end
