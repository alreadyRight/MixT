//
//  CalculateFactory.m
//  设计模式-01
//
//  Created by 周冰烽 on 2020/12/22.
//

#import "CalculateFactory.h"
#import "CalculateAdd.h"
#import "CalculateReduce.h"
#import "CalculateTake.h"
#import "CalculateDivide.h"
@implementation CalculateFactory

- (CalculateTool *)calculateWithOperation:(NSString *)operation {
    if ([operation isEqualToString:@"+"]) {
        return [[CalculateAdd alloc] init];
    } else if ([operation isEqualToString:@"-"]) {
        return [[CalculateReduce alloc] init];
    } else if ([operation isEqualToString:@"*"]) {
        return [[CalculateTake alloc] init];
    } else if ([operation isEqualToString:@"/"]) {
        return [[CalculateDivide alloc] init];
    } else {
        NSLog(@"输入运算符不合法");
        return nil;
    }
}

@end
