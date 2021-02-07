//
//  DLRebate.m
//  MixT
//
//  Created by mintai on 2021/2/5.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import "DLCashRebate.h"

@implementation DLCashRebate {
    float _rebate;
}

- (instancetype)initWithRebate:(CGFloat)rebate {
    if (self = [super init]) {
        _rebate = rebate / 10.0;
    }
    return self;
}

- (CGFloat)acceptCashWithAmount:(CGFloat)amount {
    return amount * _rebate;
}

@end
