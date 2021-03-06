//
//  DLStackPractice.m
//  MixT
//
//  Created by 周冰烽 on 2020/8/13.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLStackPractice.h"
#import "DLStack.h"
@implementation DLStackPractice

/// 20. 有效的括号
/// https://leetcode-cn.com/problems/valid-parentheses/
- (BOOL)isValidForString:(NSString *)string {
    if (string.length % 2 != 0) return NO;
    DLStack *stack = [[DLStack alloc] init];
    for(int i =0; i < [string length]; i++){
        NSString *temp = [string substringWithRange:NSMakeRange(i,1)];
        if ([temp isEqualToString:@"("] || [temp isEqualToString:@"["] || [temp isEqualToString:@"{"]) {
            [stack push:temp];
        } else {
            if (stack.isEmpty) return NO;
            if (([stack.peek isEqualToString:@"("] && [temp isEqualToString:@")"]) ||
                ([stack.peek isEqualToString:@"["] && [temp isEqualToString:@"]"]) ||
                ([stack.peek isEqualToString:@"{"] && [temp isEqualToString:@"}"])) {
                [stack pop];
            } else {
                return NO;
            }
        }
    }
    return stack.isEmpty;
}

/// 150. 逆波兰表达式求值
/// https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/
- (NSInteger)evalRPNWithTokens:(NSArray *)tokens {
    DLStack *stack = [[DLStack alloc] init];
    for (NSString *temp in tokens) {
        if ([temp isEqualToString:@"+"] || [temp isEqualToString:@"-"] || [temp isEqualToString:@"*"] || [temp isEqualToString:@"/"]) {
            NSInteger num1 = [stack.pop integerValue];
            NSInteger num2 = [stack.pop integerValue];
            if ([temp isEqualToString:@"+"]) [stack push:@(num2 + num1)];
            if ([temp isEqualToString:@"-"]) [stack push:@(num2 - num1)];
            if ([temp isEqualToString:@"*"]) [stack push:@(num2 * num1)];
            if ([temp isEqualToString:@"/"]) [stack push:@(num2 / num1)];
        } else [stack push:temp];
    }
    return [stack.peek integerValue];
}

/// 224. 基本计算器
/// https://leetcode-cn.com/problems/basic-calculator/
- (NSInteger)caculate:(NSString *)s {
    DLStack *stack = [[DLStack alloc] init];
    for (NSInteger i = 0; i < s.length; i++) {
        NSString *c = [s substringWithRange:NSMakeRange(i, 1)];
        if ([c isEqualToString:@" "]) continue;
    }
    
    return 0;
}

/// 856. 括号的分数
/// https://leetcode-cn.com/problems/score-of-parentheses/
- (NSInteger)scoreOfParentheses:(NSString *)S {
    DLStack *stack = [[DLStack alloc] init];
    [stack push:0];
    for (NSInteger i = 0; i < S.length; i++) {
        NSString *temp = [S substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"("]) {
            [stack push:0];
        } else {
            NSInteger top1 = [stack.pop integerValue];
            NSInteger top2 = [stack.pop integerValue];
            [stack push:@((top1 == 0) ? (1 + top2) : (2 * top1 + top2))];
        }
    }
    return [stack.peek integerValue];
}

- (void)test {
    
    NSInteger res = [self evalRPNWithTokens:@[@"10", @"6", @"9", @"3", @"+", @"-11", @"*", @"/", @"*", @"17", @"+", @"5", @"+"]];
    NSLog(@"%zd", res);
    
    NSInteger value = [self scoreOfParentheses:@"((((((((((("];
    NSLog(@"%zd", value);
    
    BOOL isValid = [self isValidForString:@"{[()]}"];
    NSLog(@"%d",isValid);
    
}


@end
