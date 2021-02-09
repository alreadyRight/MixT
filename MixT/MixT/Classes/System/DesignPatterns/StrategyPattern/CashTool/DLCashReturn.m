//
//  DLCashReturn.m
//  MixT
//
//  Created by mintai on 2021/2/5.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import "DLCashReturn.h"

@implementation DLCashReturn {
    CGFloat _amount; // 满金额
    CGFloat _reduce; // 减金额
}

- (instancetype)initWithAmount:(CGFloat)amount reduce:(CGFloat)reduce {
    if (self = [super init]) {
        _amount = amount;
        _reduce = reduce;
    }
    return self;
}

// Override
- (CGFloat)acceptCashWithAmount:(CGFloat)amount {
    CGFloat totalReduce = (int)(amount / _amount) * _reduce;
    return amount - totalReduce;
}

@end
