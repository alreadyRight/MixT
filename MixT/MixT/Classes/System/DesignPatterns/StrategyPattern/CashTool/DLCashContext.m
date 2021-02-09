//
//  DLCashContext.m
//  MixT
//
//  Created by mintai on 2021/2/7.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import "DLCashContext.h"
#import "DLCashSuper.h"
#import "DLCashNormal.h"
#import "DLCashReturn.h"
#import "DLCashRebate.h"
@implementation DLCashContext{
    DLCashSuper *_cs;
}

// 满减活动和打折活动有bug,暂时想不到如何修复
- (instancetype)initWithType:(NSString *)type {
    if (self = [super init]) {
        DLCashSuper *cash = nil;
        if ([type isEqualToString:@"正常收费"]) {
            
            cash = [[DLCashNormal alloc] init];
            
        } else if ([type hasPrefix:@"满"]) {
            
            // 满减活动
            NSArray *arr = [type componentsSeparatedByString:@"减"];
            CGFloat amount = [self extractNumberFromString:arr[0]];
            CGFloat reduce = [self extractNumberFromString:arr[1]];
            cash = [[DLCashReturn alloc] initWithAmount:amount reduce:reduce];
            
        } else if ([type hasPrefix:@"打"]) {
            
            // 打折活动
            CGFloat rebate = [self extractNumberFromString:type];
            cash = [[DLCashRebate alloc] initWithRebate:rebate];
            
        } else {
            
            // 错误类型, 比如直接调用传入随机的字符串
            NSLog(@"选择了未知的折扣类型");
            
        }
        
        _cs = cash;
    }
    return self;
}

- (CGFloat)getResultWithAmount:(CGFloat)amount {
    return [_cs acceptCashWithAmount:amount];
}

/// 提取字符串中的数字
/// @param string 字符串
- (double)extractNumberFromString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    double number;
    [scanner scanDouble:&number];
    return number;
}

@end
